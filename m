Return-Path: <linux-kernel+bounces-146847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D58A6BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF901C21C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBAE12C462;
	Tue, 16 Apr 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PVsbVpvb"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EAA1292D7;
	Tue, 16 Apr 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272758; cv=none; b=rjKuc1Z0s21OB6K+9SxrBXL4pFe3KEZgUfPOYm5dsjCiztQwJkXG6XOmx3bbF3f6DbQPwk3n6gzoRTvbLqb25cVpc9DOH/+OXZ/b5mqqYHdkLJfQldZjhrRVKK7WjsmPPKCMEqtBo4WTiwL4IkSnfgwcImO08svqiGB/5nZQjDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272758; c=relaxed/simple;
	bh=ca8Cl3XLzplEVm904ERihnCNiIuaG/Q+OtrmyAAJcCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gg3tb+JZKk5F697Oha9pQCT2H2auyOxLtZLwXYV7Xg9GjOWa8bRlvkkdwIaLF83BzrJiPOAUU2ukngTmm/Ogus6psEbHAM/qz5pYOId+jhYS7vSR9hXzjvX/U9pKE8U/Wq2tJp9JvmDOhq30nSO9F199pH/CDb0HtU6egW8GE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PVsbVpvb; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713272738; x=1713877538; i=markus.elfring@web.de;
	bh=ca8Cl3XLzplEVm904ERihnCNiIuaG/Q+OtrmyAAJcCI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PVsbVpvbn3NmKytdDeRSUzNTv99lozcqE2+J6VBtKbbqUuI466dhg6SxG4YCpojt
	 EcbYegfhuxm+kFJXgyC3dw7XaykV5nVLCkUGEkKCt8ToqnwAmIKlmZx8TV5nHugff
	 SKFKjFy25uYu4pSF3BsP1CfWWMXGuwguqfKdMpEGSMXjCT7V6zFMhNkViNGtA7wYI
	 ki4Nu6KiyU/7JRzAgi7uuyktzTwQY3lyXj7gCuJiVWNhzwLr30q5dsg1fTH7DOXeD
	 qqQGRyoZ+cZHTxTf2pol5Ilxqno4JKDdAzxPvnzlvUL+wFsgsK4btyc96jyGMeFaI
	 dYV6Xtla9wDjJOShRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nmo-1rp0LG0iQW-0081qf; Tue, 16
 Apr 2024 15:05:38 +0200
Message-ID: <77288a25-6114-45e3-b849-4c48116af78e@web.de>
Date: Tue, 16 Apr 2024 15:05:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
To: Julia Lawall <julia.lawall@inria.fr>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
 <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de> <87plupbm0c.fsf@mail.lhotse>
 <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu>
 <33a38d7e-26da-46e0-90d4-7137f9ec0c90@web.de>
 <3711cad3-a627-4a6e-8769-ce916c1919ee@csgroup.eu>
 <3f22920-9543-efd1-a32a-477ae18a2b2a@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3f22920-9543-efd1-a32a-477ae18a2b2a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QZe/Xfpby5Yzh4ML5dL/xWw0rfgIaR+vLFPEZOY+KKaRjk3XJ8q
 JQ8iyJRZTIH9iwJR0LdwrgqQaKNhDtH6oyxbyP52cDntgHTbyCmjy+8kqySd6cgr0jrgpQC
 hvKCDyUP2g8uh2oANsmrMHLU4oZ9c/P14wVLNn06QHfSxixH05aMaTEYTj8op34uLrRkpr1
 xpRkH6J4FRKQBrucHiehA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1M1alroXzts=;cqW/3yAUMIIAinMsv1rymEBg+14
 LeCtlnZRH6mesVjMV1Cah0nudr15ldWC9pnjdv2KA49quwI7KQqSCvjfxFQOF6QuclWQs5LQN
 4feSeRqtTZxYXpKhbqjKVs99SY7Msprt4QbjPZfup2ogjk5ci0kSTJKq7fFaiGtXlBmUZW4DX
 fHRRJk//Nc8+SpHtM22puc2R992esQ29XEnD4PYhmeIRdmOf2sVtwEno3JniXTLQ+MSKX/BHT
 nk3HvEpavLKWVM06lsug3Nu2PsfAwJtfW0epszCeOhqNrlyMN0o2BcFfH1EZQxEfytNaMTJNS
 LvMLN/HfIclphTAujelvwVFb7Nx2iLr3vGSWovjplNXaV/L11WVhpkaBQzCmNUg8o+OtyaZhH
 WNbdD+wF+kGerEqyJkZMbKLE/MNysgkk6zwhbeNw9nhCkNESnkZAbGQhL89mfSphGvHrnNzVT
 FMRXaxEeozL6kbXLoHXdQyMP2rSiMsQgmksEpTdzVJe8EaW16QK7xSBAFJsEFfqeusjQwes9s
 zfxR33i34pTmtgQAFH5iiXosrDBVyhwe/hvFvywrsKFQz9S9ktqiT7dUfrhOgTnDzYLV6SE/t
 Su7T3f/ZSvijnx9ezLJEKCOdT1ocutynBNBdANPDspCdUJXx0V3cAm2UkQUx56YIybQ2ZZwoc
 If5RMUwjS8u13FTH/fwOCsW704Pfa7Ju0ICKffMhJF8vz4OBDYkQlT5oOJfmmwh+B7nN49qpM
 KsKdJRktrGtX3qzyymArFnlNmzwnB9wMM0yjGlxd1r4isyERlifi00Y6+XazHF8jaif2Gs2U5
 hhswF+8+j1lPI50UFpMdsIL/DkMvp105vjONzZMl0c4RI=

>>>> So Coccinelle should be fixed if it reports an error for that.
>>>
>>> Redundant function calls can occasionally be avoided accordingly,
>>> can't they?
>>
>> Sure they can, but is that worth it here ?
>
> Coccinelle does what the developer of the semantic patch tells it to do.
> It doesn't spontaneously report errors for anything.

Some special source code search and transformation patterns are occasional=
ly applied.
The corresponding change acceptance can often be challenging.

Regards,
Markus

