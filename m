Return-Path: <linux-kernel+bounces-66732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A328560D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDCE28248D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F05B12F37A;
	Thu, 15 Feb 2024 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHYM8pY6"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E612EBEF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995023; cv=none; b=DQBn56YVqFlOaKSIpgAiGhtvlvo/vf8ZjJOloWa6NHDJZRTIdOKKOzIsG8WZc26DudiJE5YsC/HqaxQN1XQyJpx9kEU6qnv9IGlYwT2WHrt6UDx9cuGq/Mx1K2tnu/CoVzWrP4bE96SBo3NEqxm2EOAExAvdZR0e6hjbqfH5vz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995023; c=relaxed/simple;
	bh=OBvnn+vLzA5myTGqwxaRCsbH/Eb4JV3XiuBr+hyLuMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unhgcFVGP+805UuO2au1o4FCEdXpl5VQ63TEYF8lDzs5pyaeC/Z3Z4JGs3KzlUx5wBUFPQTW7HlskxIROjg4k4Z4Gfgth27DYeNtUCSLYt1GP48d+xb9UTAw1AHYNSeaati7Blc35b7zJwpCdeEeN3OiB3f8BjSgPA/JW68rNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OHYM8pY6; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4c081a0d56eso152308e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 03:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707995020; x=1708599820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBvnn+vLzA5myTGqwxaRCsbH/Eb4JV3XiuBr+hyLuMo=;
        b=OHYM8pY6HPtlWR8GaT57w2PYhNg/CMxuFCxTbd3aL3FG3mbbxYljhQlhHIafBDQUic
         CONjoNA6HhNvXBWb970PzhUl01c8W6SYHh/bxmTWAORxDATCuS+2md023XBwVv/1bWsv
         TGMm2OLgApVbJw3IeNV9Kpyx5AIVb6tuzWTcBp9X/iIAScgesmD/yvc6mdmpDeYmYirt
         oU4BU+rWfO9dXaGDhlHl5IPjKgFJorwfQB9dNXy5TJQ+/ce6lYzgIlc+OmWykJbG6Vpd
         grxWq3Od4+AV2AEVaWqGB8JYMdhushhVa+FKfi84gOMNYiLgP+EC+gw2FwbNT6oDsj1a
         aEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707995020; x=1708599820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBvnn+vLzA5myTGqwxaRCsbH/Eb4JV3XiuBr+hyLuMo=;
        b=Fxj0EUtzqckC35401KMulmROy2RAqZ9gkjgPzE43B3YFhUU0ylrCSlKvfc35hNZLVG
         3H726PCHJh38dIWNCmHCF1r11rQJxn+oi+VE3luGn3QylEFZZ9gZUaBdCnVJBF2t1JqO
         XH8GMrYHXpRDOsjdV71AztcrVC142pSFhC/bIDYJQkzCnPS/+B/zPjtSDCFbHsqXd27q
         jxT73Rxub3+zP4ywt70OXE0RDynHVtLRqTmC6cl90h9y1kVA7X8AMbpj9/R3wAlDsKt6
         iDy4NnrlCjijVj6pMjK2RhWjTaBeFrIHdoJ11cAIUZUmPsqhcnk6yMbzKem66MhLt3K5
         Bv/g==
X-Gm-Message-State: AOJu0Yy9ZWVM1DFtzgPxW/n5Q6rP2xM9cU1+zcOhfYHGRS1voaiOV5nO
	TUR4e3u3AU89VQHx5Vj/j/SfhdmRHSQvn+kDRw9NUT8nScuagcDy+b++0/C1MoeTp0EBUCxGKn9
	euXE/rjELC9QfU0/oqmBpHk54Mo3IevY1fNGakuV9VgWEYTRDsXE=
X-Google-Smtp-Source: AGHT+IEYRlBkhUM8iWKwiW+yr8eYjy4B779TPoJKTltHiC2zBtjSq3OeyP9rmxZ3uB2kTMQTsVbCA3nxH7Tk/iDNTWQ=
X-Received: by 2002:a1f:dd82:0:b0:4c0:2802:a1d8 with SMTP id
 u124-20020a1fdd82000000b004c02802a1d8mr969343vkg.15.1707995020685; Thu, 15
 Feb 2024 03:03:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuHF34bSbN9ktKuMAv1eOFVrf+Gw1MC_rG5trUQv9A_Pw@mail.gmail.com>
In-Reply-To: <CA+G9fYuHF34bSbN9ktKuMAv1eOFVrf+Gw1MC_rG5trUQv9A_Pw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 15 Feb 2024 16:33:28 +0530
Message-ID: <CA+G9fYu1sEsMRJg-f5e-y9PQ1hyNDWJhnWo21w6BB78Y9-9yhQ@mail.gmail.com>
Subject: Re: next-20240215: workqueue.c: undefined reference to `irq_work_queue_on'
To: open list <linux-kernel@vger.kernel.org>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 15:41, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On today's Linux next-20240215 tinyconfig builds failed on arm, arm64, powerpc,
> s390 and riscv with gcc-13 and clang.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> build error:
> -------
> aarch64-linux-gnu-ld: kernel/workqueue.o: in function `kick_pool':
> workqueue.c:(.text+0x9e4): undefined reference to `irq_work_queue_on'
> workqueue.c:(.text+0x9e4): relocation truncated to fit:
> R_AARCH64_CALL26 against undefined symbol `irq_work_queue_on'

Anders bisect this build regression and found first bad commit,

# first bad commit: [3bc1e711c26bff01d41ad71145ecb8dcb4412576]
workqueue: Don't implicitly make UNBOUND workqueues w/ @max_active==1
ordered

- Naresh

