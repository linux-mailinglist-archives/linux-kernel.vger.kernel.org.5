Return-Path: <linux-kernel+bounces-7511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF69A81A914
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB33282D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EA64AF7E;
	Wed, 20 Dec 2023 22:24:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D44AF6C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7ccd6778fso17406939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703111083; x=1703715883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+NhAvzbck5cFoq/7Xb61BYpICuo+9+ZIugcklD/GgA=;
        b=FoiLsMlOr6xmOe+JjzW/a2Spy5i/WCzrjSrYV+w/rHedQDV53l1T9Ya1gtK8jwrEgq
         CHY0xviOp1DpInxYrhZce/Bb7ELMMPypWLIujxhQ1iEKhyypLsz3pHsRNbKIY+XuV6Xw
         d5oN5mr9vamy+93G1CV0DGWS8jmcD//TXganXf0OaJmVUoK3kSGVjbYnWHK210+93W8B
         aUhwb3KXTclurCbxUNdA7wuNdTcbdqg2YWXxfkcqRNWXkCWCgNrnYg3yEo9Dl+iipskS
         OMb+WTgVEc/h6iea3L0xgqfXrLbdEBC+ZlnybVAMz/tLwOzTWl45G1CN+cmYVCHTDdcA
         yQZg==
X-Gm-Message-State: AOJu0Yz1r6Adw1q+ezCIRoSgCtOPTHJA6HQ9plailEuGunteDH4gbHO3
	EnZNPEfMkunEU+JAkFLuV6ZP0oZDjuJDZvhpbBXoKVJNc0Rdccc=
X-Google-Smtp-Source: AGHT+IGF4tnehJoQ8b5mJeuZ3aD+AN70n7SCQUhDZe8wyBTWkaL2HRGtc/TfkXHKLRSj7/fK9M5O7U1z4yPxGLrBW/VE25JiGMFy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1612:b0:46b:c856:66d3 with SMTP id
 x18-20020a056638161200b0046bc85666d3mr75280jas.1.1703111083321; Wed, 20 Dec
 2023 14:24:43 -0800 (PST)
Date: Wed, 20 Dec 2023 14:24:43 -0800
In-Reply-To: <00000000000037341d05fc460fa6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022725c060cf873cc@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: invalid-access Read in __packet_get_status
From: syzbot <syzbot+64b0f633159fde08e1f1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] KASAN: invalid-access Read in __packet_get_status
Author: andreyknvl@gmail.com

#syz set subsystems: kasan

FTR, this is a false positive in HW_TAGS KASAN; see the discussion here:

https://lore.kernel.org/linux-arm-kernel/CA+fCnZdeMfx4Y-+tNcnDzNYj6fJ9pFMApLQD93csftCFV7zSow@mail.gmail.com/t/#u

-- 
You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/60c5f1c0-90b0-4e87-8cea-a5bc1ccbe47fn%40googlegroups.com.

