Return-Path: <linux-kernel+bounces-816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A37814698
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E73A5B2378A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A862DB78;
	Fri, 15 Dec 2023 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybQP8bvN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C072C691
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33638e7f71aso268181f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638952; x=1703243752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+ooKEqmsF7QvtbpeG1r1pA2WmE89GFiP0WEgLh36AY=;
        b=ybQP8bvN29AWzEJO0TrF5/Nsva+piSZZrCfBTa6liAUPisaYe0JGDAm7W/qSTRqw3F
         4iaCK62Y5tpEKH0ka9goIbC4l8E05h2O9JfhBZb+55RkknJRCehD87gYSN5gOeO/6mo+
         zgKUwaGUQqUC/8NloLH9rA227lb7pekSz3LwHzOFd20FWWV6e5hyUhDsuhab1IzgA8uM
         HpsM/AXb1bz/ptqFTK/Pg8CE2psV88U8hOwY704FGZF1XXFvZji1e4lSphmMbkDfQE/d
         /8DzRbhpcZ4sOZB7gaonJn106GF1+Uv4KgbkIoyt/bw7LcpA+ALr6gza3Gbetv/XuSbR
         EtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638952; x=1703243752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+ooKEqmsF7QvtbpeG1r1pA2WmE89GFiP0WEgLh36AY=;
        b=wnkrir86GFy3EFaJ9mEMFR7zMvqM7e7fh1Y5MFYpNOtv3LDoYuFQ0xSeDkRdktGDj+
         ktzeFCkjigwJFG8hQHjSKahOKbGUnZTcdkNviPy7yU/J60kO3RTbj3qGEysGmVmsAF5I
         6NrgZYi3c0cwZqlkaUhzz+uYZBkIV1fTq9/gZD6YCLao8HdDVStiGbt14WXGUArhgNk3
         1lNpJE6ebF8LobB39BAzHhfUD0G0LJwz7Mry/VP2AbHJuNeBUu0f5Edj8Qbmj6+qg+RB
         UmR5xpn2Z+Qk+/EhizNtof63eIcG+EjyvQh7YTY7EY8CZ9VB9dcVOnCMtgFsDgxUI7YW
         hmRA==
X-Gm-Message-State: AOJu0YyZtKYjKxse7VMnf6Wqu+dwCtY8uIcOSeN1HtD1e6GUTKTXsprl
	6SpvXY+bnlwUWQGEupBNcHQXIFCOSu5eEg4mFMg=
X-Google-Smtp-Source: AGHT+IGz1rv62aik6ABY9CfctpgNJd229+a0US4HYze0O5k6sTCpndWCcrZ/P+HXsLlki6N6RPh9zA==
X-Received: by 2002:a5d:6ac2:0:b0:333:38eb:8949 with SMTP id u2-20020a5d6ac2000000b0033338eb8949mr5985493wrw.25.1702638952500;
        Fri, 15 Dec 2023 03:15:52 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g13-20020a056000118d00b003333d46a9e8sm18511497wrx.56.2023.12.15.03.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:15:52 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/10] ABI: sysfs-nvmem-cells: Expose cells through sysfs
Date: Fri, 15 Dec 2023 11:15:33 +0000
Message-Id: <20231215111536.316972-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
References: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=rDw2aRqd4VB4KQrERUdheIoqHQ7dZxBi1jfzVJE5aW0=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDVYlpIsMnIDm7GHut/qUakpchD85wEJ03JP8 hLvUbzLP1eJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw1WAAKCRB6of1ZxzRV N279CACRaGwuqabts3hC8cLlJ9C+ljtD6Usa4/RGBkwhV5+yE4PP0TZfa2+EfOsxDFQ3Io5UK8B /WlfduyfDSb2fwIgNU0udTpy7a1wSvq0o0rmRVrK4ujU77+aOzPwy8coo/S4ykYkiUIISYrIq+z KGtH0MW9ym9uQeTxxxuDcnjcwkJmBoGXXJTDTpA1KwfYcVWAA1FZCh9qG7NXZ9WCuo8DgmI4/b3 FDfudF10K5GA31KPPJLG6BheyKENdeVE5pC1D696OyhVuiSXF1RScSdJAHGSXyt4wsNFUVXjVqE 8moMwpZ6pvQAU5aiB79J3iK5zcSVX4U5rW4LXqXKrgrthc3U
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

The binary content of nvmem devices is available to the user so in the
easiest cases, finding the content of a cell is rather easy as it is
just a matter of looking at a known and fixed offset. However, nvmem
layouts have been recently introduced to cope with more advanced
situations, where the offset and size of the cells is not known in
advance or is dynamic. When using layouts, more advanced parsers are
used by the kernel in order to give direct access to the content of each
cell regardless of their position/size in the underlying device, but
these information were not accessible to the user.

By exposing the nvmem cells to the user through a dedicated cell/ folder
containing one file per cell, we provide a straightforward access to
useful user information without the need for re-writing a userland
parser. Content of nvmem cells is usually: product names, manufacturing
date, MAC addresses, etc,

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/ABI/testing/sysfs-nvmem-cells | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells

diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells b/Documentation/ABI/testing/sysfs-nvmem-cells
new file mode 100644
index 000000000000..7af70adf3690
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-nvmem-cells
@@ -0,0 +1,21 @@
+What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
+Date:		May 2023
+KernelVersion:	6.5
+Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
+Description:
+		The "cells" folder contains one file per cell exposed by the
+		NVMEM device. The name of the file is: <name>@<where>, with
+		<name> being the cell name and <where> its location in the NVMEM
+		device, in hexadecimal (without the '0x' prefix, to mimic device
+		tree node names). The length of the file is the size of the cell
+		(when known). The content of the file is the binary content of
+		the cell (may sometimes be ASCII, likely without trailing
+		character).
+		Note: This file is only present if CONFIG_NVMEM_SYSFS
+		is enabled.
+
+		Example::
+
+		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name@d
+		  00000000  54 4e 34 38 4d 2d 50 2d  44 4e         |TN48M-P-DN|
+		  0000000a
-- 
2.25.1


