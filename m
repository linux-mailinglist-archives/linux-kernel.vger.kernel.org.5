Return-Path: <linux-kernel+bounces-26022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE0282DA0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBE51F21F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C6117549;
	Mon, 15 Jan 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hiqZXOS9"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3717543
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso3784841a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 05:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705325193; x=1705929993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IyOnHF1CwJGniYfmRqVSgo2mTJwZim+cx2rzTCphPsU=;
        b=hiqZXOS9bmKtuzLCgOndl3imhuDBz0TCrrtHtlicmROABPachWU6jLPX4WeoVzeuWf
         rx8+2W06xqDX2ytT7oPoPETXzG8DraERCJ/eboXcUDsU0H8Ng+7ybsCGnBDpKLOW1fa7
         FlXlmQkf5FBUUOsnfanFjt9HsttVqaBNVebRbKHkY1fecA3cffhU2OJRWav+HZuncAm9
         gCyTugDhzpwo/hWo8Z1xy78yuTJWpf0Yq6a+zX5qTDnQdNhyEv8BhJbLeDVwwBKQdh7U
         cIDoSOaN6F/1DlGW5Nsc9ClwWOIDa/dGSHkafL2mC+aARg8DKiq2fy1IFD13xbgYMBeV
         uv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705325193; x=1705929993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyOnHF1CwJGniYfmRqVSgo2mTJwZim+cx2rzTCphPsU=;
        b=Ne3t/ysuXidFhpytNt0svibvQVzvw7jm9Z3q/h3EEKlAJ88ZS0JSR/Qv4PdSNCcfB/
         EGy86fsOO2F1ToPrF79cfULAAvgb5FCHmt+yniXmMddX9ZLn3J5U83azbeGJtl2EcHNb
         lhll4Am65di+XnB3DItwqGw5r2FMjIjl+84Mvld46ECqZuJs3oX2Fwa7953Vq6AwJ+rF
         sA3VGtEptiBQL4zFHDGBM28FiNcOW9J3lnct7XR/K3e5z+JTMavS2oSREwyVooUuruIW
         6spAn/3steriEMKSSIrdKJkLoLeAOUqfdILF9ALtSI2vcFhdq2imEurcMt7KRp/vA0uy
         dyOQ==
X-Gm-Message-State: AOJu0Yyiv5ftbD2Z4zilZNOMEhI+Dp8Xc8UJ8CUlXedQ44HHuM0V2VTw
	oqacRMJG7ZEpcQQ9HpexXOstcW2cOv5NJBvAYO1gaOJF3xJVdg==
X-Google-Smtp-Source: AGHT+IHpfSLUAMUz2mTi0nD3uyJwZKJ+1gc5br6HLQh44twTJk1Ii97wz9TzoMBvTsR5ICJ2Rv6W5yU7Fe8iembBKb8=
X-Received: by 2002:a17:90a:c90d:b0:28a:325d:1ed8 with SMTP id
 v13-20020a17090ac90d00b0028a325d1ed8mr2527052pjt.26.1705325193217; Mon, 15
 Jan 2024 05:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc> <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc> <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
 <20240114151250.5wfexq44o3mdm3nh@airbuntu> <CAKfTPtAMxiTbvAYav1JQw+MhjzDPCZDrMLL2JOfsc0GWp+FnOA@mail.gmail.com>
 <20240114195815.nes4bn53tc25djbh@airbuntu> <CAKfTPtCGgJiFDrZYpynCiHBnQx48A9RsAY9-6Hshduo4ymGJLQ@mail.gmail.com>
 <20240115120915.fukpcdumntdsllwi@airbuntu>
In-Reply-To: <20240115120915.fukpcdumntdsllwi@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 15 Jan 2024 14:26:21 +0100
Message-ID: <CAKfTPtAMacH4hKLyttLuQJjzc=D4m864MFaEEwZLG4K8RKTDYA@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Qais Yousef <qyousef@layalina.io>
Cc: Wyes Karny <wkarny@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jan 2024 at 13:09, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/15/24 09:21, Vincent Guittot wrote:
>
> > > Or I've done the math wrong :-) But the two don't behave the same for the same
> > > kernel with and without CPPC.
> >
> > They will never behave the same because they can't
> > - with invariance, the utilization is the utilization at max capacity
> > so we can easily jump several OPP to go directly to the right one
> > - without invariance, the utilization is the utilization at current
> > OPP so we can only jump to a limited number of OPP
>
> I am probably missing some subtlty, but the  behavior looks more sensible to
> me when we divide by current capacity instead of max one.
>
> It seems what you're saying is that the capacity range for each OPP is 0-1024.

Yes that's the case when you don't have frequency invariance

> And that's when we know that we saturated the current capacity level we decide
> to move on.

yes

>
> As I am trying to remove the hardcoded headroom values I am wary of another
> one. But it seems this is bandaid scenario anyway; so maybe I shouldn't worry
> too much about it.
>
>
> Cheers
>
> --
> Qais Yousef

