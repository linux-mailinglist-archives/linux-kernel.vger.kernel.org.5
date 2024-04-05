Return-Path: <linux-kernel+bounces-132734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29E8899966
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7878C1F22B24
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B782915FD08;
	Fri,  5 Apr 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kNaVjIes"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF11EEE6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309251; cv=none; b=Yr3mQv42c6I1SFxctOe9EE+QH4bDsoVBiDRA4shVm6tEiQXF8VgaReUWci/CQqRzPhvg02JS7vsVQ8mbxySYU5QMFz5qHxD/iu0pLuyaQSbzll7NoTevyc1OxkHHqrMZdPzPDolRqUS8DCs1bCfMRHsHNGL+2bhQV5CQqd7bnzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309251; c=relaxed/simple;
	bh=f7oeIVMYq643NoyWscupQPAYNamXXBaZyabbc0X3A8I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Rm9UoMuAGpnbSoZX8FVXKVrXJ78ii42e2lAwn+z7yC4g4VWJnguWw25kG7Tp4xbKLukk1A9SrPYAMcIdIZ9ctHGmfcFiP5C8PSPxs+GGqEvWkCIZ00ql7Z4QdIx3+oWz084g9Dy91r+4/vnhoRsprWgcAjWKavmvRNuU+eKru9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kNaVjIes; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712309244; bh=zD0ddUuisWwXHfo/fgE2fqG6hlr31u+EGuOPSrgTnbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kNaVjIes1rD8H0MnBvqg2iCrS8CLuyujUhA1RVeiPWmh8eZozogoHJ+VLuyESlZdT
	 GGgpexBxS9cU3HvOq82vor06tq432FOZmrYdgqAXniVojfJqjdOarvWpznpbiCFZn/
	 ZbwCWy1hJcqc1eFE3GFPwAPAfBbI4wz7For4831w=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 6D6B7E75; Fri, 05 Apr 2024 17:27:22 +0800
X-QQ-mid: xmsmtpt1712309242tcx2k7xvs
Message-ID: <tencent_1604493766D774A6CD337CA363296C63B305@qq.com>
X-QQ-XMAILINFO: M1xqn9pGP6LNUYbSmejPSGeB09RDZEiaMay8GlacZgwn6CkrfPl8Oj3ecYltcJ
	 aaWDRaBKnDQqVcy7zH91fTXJ4Mee+PSBrYUjg4iRP6acHPgnvTqObU0MfDhucrovd8ixU4SMPbro
	 HMZ3BX6Gi4SP6xNw9AEXJBFoO+s3R0CRj+jLNHt5PZtzYL2yEZy44wGyGjeIkvbRCwxByOtA4vtg
	 K7egyuBmmzEiL8XPSXU9GOJILQBK8yy21kbTrWh0zFfQgMeuIjdh+tYf4/5YlRs95kA6/cu99y5O
	 9Tr6oTjhR7fANgZWmDeO3NR4KMCkcS5gUeAxIUYYOJsZolcJQWvSz7ON21mV8bJ447a2zYA2K43/
	 X3yEewt2ImGXeRGbBUpos0ybIjnDUZ2JK/Ag4plCyyuzoYfiSumRl9r21EOZhbmPBjD7FWa8rxwQ
	 5kmJDoRgyvddvG3M8fp5HgFWcbwBSnCt+ua3PLtmqdMrP5KD8b6MCDTow1wz6DDjU8ApXin9Wnr+
	 4cGOC+A4Z+Pt2WJgaXRp85tb/vKYHq1K/97SbJ8tUqqMJ587WrEPweg5FI2JiomTltUUJjJevn3i
	 4FHbxG3rMzUHK47aMHRsRdL3BXhKr7TQmaIniOhUF855K/iz8GLHeiCMyCSY/jf3WpypWGz2EGfO
	 0yJoNeXg/18MuwCbkaKBwo14yyQgC0JFz9vY/5v0CuDam/+n7dkd2X6TGs7rBGo25n/7nJqDjsyA
	 sdNMh8blP6enNZbmOZc1cgfiXSyxd3BtGkww7gTzx3zwlzQvrHqBeA6QpxmaNrzz5RKr/JAxSg46
	 ThQDpuwQv/0TDYIcH245rZa9f7zIUHaLdwF/xV/Bpy+XLVADJW7OCh9Ak8ZOOEgnhRB2DMoKTZtn
	 PsI5QlgecGPiQWYzhJ5m2gJhjCPWHSoQv7WAvWx/uBObjBIfzUUOqhD7H+vkJctMZKhKPsdgOe
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in hci_sock_setsockopt
Date: Fri,  5 Apr 2024 17:27:23 +0800
X-OQ-MSGID: <20240405092722.514984-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000007558ae061553f41b@google.com>
References: <0000000000007558ae061553f41b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in hci_sock_setsockopt

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 4ee1b976678b..cee7ec1adbd2 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1946,7 +1946,7 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case HCI_DATA_DIR:
-		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
+		if (copy_from_sockptr(&opt, optval, min_t(int, sizeof(opt), len))) {
 			err = -EFAULT;
 			break;
 		}


