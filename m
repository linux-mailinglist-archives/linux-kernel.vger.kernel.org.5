Return-Path: <linux-kernel+bounces-137058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F4889DBC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3C4283F90
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBF012FB00;
	Tue,  9 Apr 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QbA/vVeH"
Received: from out203-205-221-247.mail.qq.com (out203-205-221-247.mail.qq.com [203.205.221.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097275809;
	Tue,  9 Apr 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671686; cv=none; b=jKFA6Xb39jHt9TItvG7bVcmGEgxL3W5J+nSNdswb6HIGWmaZE1qvybtS32Kne45Z+5XXEglrb8FpJfRXAcA/YL6XM7Nxjk72zVO+ufRWFgutusK7iUg/wZqaYZrCWPE9bl55UfT5gkMB7EH7Wv2QI/FUpQgLD37DUI+RiAUXIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671686; c=relaxed/simple;
	bh=aZ3VspYYkKY1SKuWGstld2SVTKAJS1fjt3YHHePeFqk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hv953NuHCJfBi/JSskVfRPCK3di5fyvtxgQZLZf23qYB6degIL5t8tiJsEyoN3QhNHtNmeIAno+mnu0GLIQrowoWpj3t595ruzXivjvfJXWchNmJincwKufmfljzYrOe/1nircYknIlIMzrrXz+ZuNRtFF/kmi1eExl45xtVchk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QbA/vVeH; arc=none smtp.client-ip=203.205.221.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712671681; bh=Nq7x37qnBv79sD920Br4gJu3bwEbV/pMCm95FU3naDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QbA/vVeHqGIdL6GIN5Aabs8VRYJcnKVkyAEZpqoJnTbrE+UVVtFogERdirJS5TTx8
	 8G41AnRxLXGdb6W3TwtTKbx+kbcpxmqur6/OwhdRBnGuDTY0qFCrC6zqJUsAypWzLU
	 /IGMoU2dERkECnOmypwBuOt+zb9j+HKt0j9kAjm8=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 6D16000; Tue, 09 Apr 2024 22:01:45 +0800
X-QQ-mid: xmsmtpt1712671305t2hlw4hd1
Message-ID: <tencent_88401767377846C9736D0363C96C23BB4405@qq.com>
X-QQ-XMAILINFO: MXFwphgysCmN7alFT54dUzQwy3Yf4UCiwHgtXIu9oHZ6X2/XiOTaFGgsyzuF2u
	 BWJEbWMOcQXfFTLTOQpeeXrdVWRtoapk4/0M7AQRhNgbeFb62N+u9liwhKDDAHWWegr8w8OkiBw1
	 ioQ42KrhMBTgM52VRYhCcNhjT4eab7Zsq92OHoTtzRqZHHkpu5No+MlG+0E4yudhDgiKQWivQCKg
	 cLqEuj5DtRR+UPU9xjL3DQNckNqMF2Wi9kWe83m8eezRIloBb2d4mfQdO80iVoFBRwLBj4HMfSM9
	 dkS5QOzS5BNfLV6I7gqEpiwVwgjbN7DAxqWwh8UB20bZXEaeVPthNVidYI4DZKsuobSzErjlGuVv
	 l5HOy4xpNztv22onDE10Y6EhZ0rGXIYr9I+oNN9P0eRCyjl/EA1/sknQaqjxgNNA3mFAdbmXeBCB
	 oNCUYgStbGpWPDYCK2hOTACTrgwcBPOomlREYsuS0LRiKE2CSdDEW+6PLLo80ZbPN0PO27xVP3HU
	 kqpKiIiSLoIuE+rrA0tuSRF1HwBLvxsn++9qD4eiOL6hZHuR25pC8vxyAUprvIM4lyAvq5lU6T2T
	 O7A+PresvyPjUyIroSypXsB7xBe0ZXlVG7M4HuU7kZOvc/96/nH/tbCT3BS12yK4WqtoHBIPPkQs
	 h5dD73wlRTamZCMYrcNlii3Gt35JL8MsVTCoK1jQ0HWWJ0UnQPG+HXBQqt0Jw6qIIyhmaRXf25qQ
	 acGhHoF63hZfbTa5e8U4yTLVykNw+cm5V7CZ1GJHydpZs4+5/Pu/24cqwCXntRla5HTup+ONOEHt
	 WNsGEcTuFVELID/U1nLr9wVtfi1HCGt6eO8AbsVSFPJEGquYzhg3RTBVYBEM3HcCEWv7dafBhvjO
	 0onQLX5QebODGDtWpSmG6KGNNOjlaeWIAOIyCtKkPo7aSTeBSc8Nr+edtaTYlaBjRH6ZENX1Y501
	 R831j7dHsTX5gaL/RILH+sbcR5GSJlRQBRqGD2x1CiSAGxI5NYWPHhrv4tKSRNps4pxkx2INMbGW
	 7V3eDBB9LsqkXRQj4a8WTCnxd6wjQ4gjNKdwHTIAdNuzNfSSYGM/A6zhg0F4hUQgHjb9R9kgk28Y
	 zyKEdW
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: eric.dumazet@gmail.com
Cc: eadavis@qq.com,
	edumazet@google.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] net/socket: Ensure length of input socket option param >= sizeof(int)
Date: Tue,  9 Apr 2024 22:01:45 +0800
X-OQ-MSGID: <20240409140144.28412-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7cf0848b-f44c-42ad-848a-369a249bff77@gmail.com>
References: <7cf0848b-f44c-42ad-848a-369a249bff77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 9 Apr 2024 15:07:41 +0200, Eric Dumazet wrote:
> > The optlen value passed by syzbot to _sys_setsockopt() is 2, which results in
> > only 2 bytes being allocated when allocating memory to kernel_optval, and the
> > optval size passed when calling the function copy_from_sockptr() is 4 bytes.
> > Here, optlen is determined uniformly in the entry function __sys_setsockopt().
> > If its value is less than 4, the parameter is considered invalid.
> >
> > Reported-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com
> > Reported-by: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com
> > Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> 
> I think I gave my feedback already.
> 
> Please do not ignore maintainers feedback.
> 
> This patch is absolutely wrong.
> 
> Some setsockopt() deal with optlen == 1 just fine, thank you very much.
It's better to use evidence to support your claim, rather than your "maintainer" title.


