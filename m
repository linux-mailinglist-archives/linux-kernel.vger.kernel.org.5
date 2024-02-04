Return-Path: <linux-kernel+bounces-51517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60A8848C1B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655011F2354F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967E81170B;
	Sun,  4 Feb 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="O9N7xtDW"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B711711
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707034965; cv=none; b=ZK1MtUtvmUexC4AMdObR3Dv3YzutAf7LndOtdUHFaZT3zuADzJ/fKK9x/LE1gvOJJlvzrQq0ZTLqdV62G0FsxIBuyST2m2mlFMinYwRORCCJ2gkPlmb5lK0+64q3FET/IZGlOMG2x4dj/sScM4c9zvUFtUwNEJZxmT91jFiJt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707034965; c=relaxed/simple;
	bh=TDecslxQsFJA24T/2Ma18VCiVGGXycudBM26+Xkn2ho=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=b+R7/e9ZqUgJqtPXV/YVwkmPMxgF93c5Xs6syfXFxpUJHUi5fuXWj9GM3AVe7iuhK/O2GPuLiR0SYWBKPxPyvzcatz63X0hLU7ggu/i6GeHyqVP0n7dGc1OAXPA8z3NAELBg8tbIK9pMGgGxZapVddJoYRhtbQAjsJkecsE5Py4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=O9N7xtDW; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/4Sf7Nh1y57mEEKJISz8gauinYF4LA7bheuQvuOEyzk=; b=O9N7xtDW22Jpi41dE9pGYhmu2y
	xxZP/6FkCZ/3NvNrrYWTvArD/5dH+X6xodQEYhQXerIwTrGmpDXf6yb/SLIgsnj/WPwBFecO5GuVB
	mroq2wCS1N1ddpoCt1zcgoDRv46cVWZ2dskMA2YdMhrywTrQ0nUXQ5CGzMhbmYaF2vlGdr0OqADoG
	dbXVFdJh728no6Ob/HT5EHSV2JrFqtnwHX/c37uMdaCXQlTSJ9nkvJK23kPl+YEvdKGhWGetkbK4v
	/6iIGNZanpxe7Js3Ct182UyiSex8pRBhntmRoTZpvJpOtuMhdNgf7pgaXluEep0IN8ZLbzqGHyhOH
	zfVHry4A==;
Received: from [2a02:fe1:7001:f100:a96e:14c:a9ad:b2c2] (port=50589)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rWXlr-009Tlb-MN
	for linux-kernel@vger.kernel.org;
	Sun, 04 Feb 2024 09:22:35 +0100
Message-ID: <a8cf7569-7476-4467-929a-1cb59603984c@cu-phil.org>
Date: Sun, 4 Feb 2024 09:22:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X (was fair source)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, my test channel is now Ban Bukhari.

https://www.youtube.com/@Labour_Party_Digital/

This is also labour party politics as allegory.
The Marine Hu symbol also is good for understanding symbol correct 
allegories. Hamas does not want you to know about this.

Where Breivik (the masskiller) has been associated with Labour Party 
politics, and we do not want that association. Instead we want a correct 
association to Hamas, who particulary use the Bukhari book, as a swine 
eating allegory. This contradicts the Halal principle of Iclam, and 
"Hamas" covers this over.

This were Breiviks "spiritual" tutors. (And Osama Bin Laden, earlier).

-Get your Fair Source politics going in the best way, from this angle.

Peace.
Ywe Cærlyn.

