Return-Path: <linux-kernel+bounces-30258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A309831C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2460C1C22BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B832C6B4;
	Thu, 18 Jan 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="M7itMBFB"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7229438;
	Thu, 18 Jan 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591349; cv=none; b=mb9MKx0fiKF0ZyNBwyih0bTuqWzsIy5SiOukhAZGtqORJd2KjL3nQEfU65k8sW5fhQe6FMMob8bWqewu2qxQ6TmD53CZsqWb0Seh6z+94SWEy4M99lq6vIfi5AZj3Hd0Wh1Ppy7aIC7tuYP+a9YRYBxEOuJVsmrL+WdHKmye6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591349; c=relaxed/simple;
	bh=WCYfehzx9x7lpXC5TGZv+O+Qvu6+XT2vg43AOYiq+Sk=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=FnXMyvCMGDg0XhMZLXCgbigVjMVBb5+GK9D9HL3YEkh10vLZKYEVgdWtcbpsyix2UCuWOfncnA00RlxZh5/i3wkCOPr8BO+lQppSTKFTJQIt95uh6NqRge33dH2KT7CpP35zc+IoEZLLJYTfAxK8OkC0kUmK/Y7XghBebY3PV4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=M7itMBFB; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=1rMZTAex6XTx0IWwRU2SqD5FeWemqzbtBQ067YEFSk8=; b=M7itMBFBAq0/ZHORwrv1VQK0g0
	DlmqqEObs6c/T9h+2LB6IDXq8//w8GUKzTFp49BAvb6UyQpxzzTnTHdbTTbp8CGOApHgWskz1TvcZ
	FDIYFEUwUNVc8d94mtL6AaziVm/Tb/8Sp6FylBpPvISyROD1BgHd8XQRr6DOLg53Lmt0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57058 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUDo-0002lf-CH; Thu, 18 Jan 2024 10:22:25 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cosmin.tanislav@analog.com,
	andy.shevchenko@gmail.com,
	shc_work@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 18 Jan 2024 10:22:02 -0500
Message-Id: <20240118152213.2644269-7-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240118152213.2644269-1-hugo@hugovil.com>
References: <20240118152213.2644269-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH v2 06/17] serial: max310x: remove holes in struct max310x_devtype
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Running pahole shows that there are some holes within the
max310x_devtype structure.

Remove holes and optimize alignment by reorganizing structure members.

This can also lead to data structure size reduction for some CPUs.

On 64-bit CPU (arm64):
Before:
    /* size: 40, cachelines: 1, members: 6 */
    /* sum members: 34, holes: 2, sum holes: 6 */
    /* last cacheline: 40 bytes */
After:
    /* size: 40, cachelines: 1, members: 6 */
    /* padding: 6 */
    /* last cacheline: 40 bytes */

On 32-bit CPU (i386):
Before:
    /* size: 32, cachelines: 1, members: 6 */
    /* sum members: 26, holes: 2, sum holes: 6 */
    /* last cacheline: 32 bytes */
After:
    /* size: 24, cachelines: 1, members: 8 */
    /* padding: 2 */
    /* last cacheline: 24 bytes */

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 27c8ec956691..21f2fa3a91e5 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -258,11 +258,11 @@ struct max310x_devtype {
 		unsigned short min;
 		unsigned short max;
 	} slave_addr;
-	char	name[9];
 	int	nr;
-	u8	mode1;
 	int	(*detect)(struct device *);
 	void	(*power)(struct uart_port *, int);
+	char	name[9];
+	u8	mode1;
 };
 
 struct max310x_one {
-- 
2.39.2


