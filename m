Return-Path: <linux-kernel+bounces-4492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D7F817E25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2852824CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0DB8059E;
	Mon, 18 Dec 2023 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rnF0TVjY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58317CD11;
	Mon, 18 Dec 2023 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942021; x=1703546821; i=wahrenst@gmx.net;
	bh=Erl1Hx4Iu/yc81ICtgx9HU1UabMeGNtOb5CM3iti9fU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=rnF0TVjY08uoxNM7/WoMipJTWdi8B9x7KbEUdQebAk2DQDoXUd40C6BbxNTU22nM
	 iqW9bZN46045c3grmml1lxAhjHgQ8GqLlWxjIbHaQnYEN/fOEuhJg3KJEYdje4dnd
	 SKpSt/nsmtHOcpkA3drGdN9rPqyLtjUQFJz49cghjc+CZeqjRMwkdh5udPZP/JpXb
	 kTm7/OeLA1BfSFsmKieoXV7ClE0exvlLNx2mPvvXeokrw8TLQ5zL7/eWLLbLIj6Lk
	 MXQihMfklFEMqlPOWijyXTYETgeo1jZMlI4mtQGllupOr8KtuAAyvkwEJsZpHgLL4
	 8ngnROy1ORckKVBiBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwUw-1r0rxw44aa-00uEmd; Tue, 19
 Dec 2023 00:27:01 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 11/12 net-next] qca_7k: Replace BSD boilerplate with SPDX
Date: Tue, 19 Dec 2023 00:26:38 +0100
Message-Id: <20231218232639.33327-12-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218232639.33327-1-wahrenst@gmx.net>
References: <20231218232639.33327-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XTyNWHeOORMarYYVkt2U/alUzIyx4EnLzjFka85by091TafT2fr
 iqVyAletEr4A/6bb266fmjm/BUq4Ss9po6AlDagjw0PZzhpv/3PUScYdtoJ/jB+VCQ9uBe8
 bs5SMn245OybM5SmPu+HJpDnM9vRKxPzp8uP/mAJDNweF3tBw0U6BEL1ku/xMvRUpPu59yt
 ly9qsLkekyZYSZosVzleA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:esTuO+Wo5Zs=;RhUYrbas1tPAtlD72JAleYuQw2h
 hcJjirKh77yVTi28sztzSdz43fWMbB1ZWoBLK1I4YhO66bz+8XHCN9Aja0SlzsZDGljr9Uve+
 U7bAjgDsCvJOgVRPXhQGm+itK65iSEFz4bjLLNAtjvvVMrv/r3nNpOBhE/VRrtiEDFd6mppLk
 f4Du+JE4twzeQyjjjEHSryOdadkGmtRuLu/RvN29SVcVU9uuhFAUWIDoehfjVcW0ag+xFU5qL
 aEPVRYgddX3XqSPukjE1eBZpXu4UjZ9MF6O6ZWabzAWSu7nHqD63cnVeh7n0lso8oXMItFJlY
 3P0hWY9LyMnVd/FbWQnHrBrArEiSpFWsoFR/JeVElmv997P49L7RePSiug4XmTes+omreqNWo
 c03ve9EF2nbAEANmz5gRofAhpCKTmLcn2dfyuyWraic7eeczuSrBWPYaRjirwuyfjWn5cF4Oz
 891e29nHmmn2IjNmYi1q1J1cj8CGH6fq9a0fZ16vrV+2EwInxOefy3KLg/WtT4cFKdfRfZuu7
 idosPGdDfatyGoOmcTptJjty5EMJEF8Ba+KEWb5zTSLL0b3GpTI/qqM4B0FZMjQfigWMIPy31
 1BIRLZ+o5iST6HZfHMHJ1JrwQk++6NPCHIOIX7kuC5ut4YPRvhj9kjQlSc4547KjvSCA4RT6g
 CyfOPB5Qdf/+yf9G3sf3QD9Q9Mry9HukG7U/II4WgZ96Zv5iGCU2NsHScqBx2iAP7FZC0cgz3
 qlwCqTaphglZOFEsF6f+oucqT67vwCxuYmG5LamJlavinqCB1Our5pe/GsfDq8AX5OUaM+zyy
 TUidugyPxKUuOO0WBGeN/0Gdtua7IW8PY2f1Lp0X0uMLvV3JSyhHGnb39bNNM37Yjl9pgoWpr
 GjTaJr9O9CcQude6b1OFvAyE+jhCW5zc1lad3eanA3Zs9rC9Apl7y1gZ4Oq0wV3PNL0eKGbJh
 qr/xykSaF6iYhCAAYnU2IdA6+S4=

From: Stefan Wahren <stefan.wahren@i2se.com>

According to MODULE_LICENSE the driver is under a dual license.
So replace the BSD license text with the proper SPDX tag.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k.c        | 17 +----------------
 drivers/net/ethernet/qualcomm/qca_7k.h        | 16 +---------------
 drivers/net/ethernet/qualcomm/qca_7k_common.c | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_debug.c     | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_debug.h     | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_spi.c       | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_spi.h       | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_uart.c      | 15 +--------------
 9 files changed, 9 insertions(+), 129 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k.c b/drivers/net/ethernet=
/qualcomm/qca_7k.c
index 4292c89bd35c..6263e4cf47fa 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k.c
@@ -1,22 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- *
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- *
  */

 /*   This module implements the Qualcomm Atheros SPI protocol for
diff --git a/drivers/net/ethernet/qualcomm/qca_7k.h b/drivers/net/ethernet=
/qualcomm/qca_7k.h
index 356de8ec5d48..828ee9c27578 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k.h
@@ -1,21 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- *
  */

 /*   Qualcomm Atheros SPI register definition.
diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.c b/drivers/net/e=
thernet/qualcomm/qca_7k_common.c
index 6b511f05df61..be2f754efd21 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  *   Copyright (c) 2011, 2012, Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   Atheros ethernet framing. Every Ethernet frame is surrounded
diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.h b/drivers/net/e=
thernet/qualcomm/qca_7k_common.h
index 088cca7f61db..44ed66fdb407 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.h
@@ -1,20 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
  *   Copyright (c) 2011, 2012, Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   Atheros Ethernet framing. Every Ethernet frame is surrounded by an a=
theros
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ether=
net/qualcomm/qca_debug.c
index 857883d0b5ed..ff3b89e9028e 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   This file contains debugging routines for use in the QCA7K driver.
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.h b/drivers/net/ether=
net/qualcomm/qca_debug.h
index 46a785844421..0d98cef3abc4 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.h
+++ b/drivers/net/ethernet/qualcomm/qca_debug.h
@@ -1,20 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   This file contains debugging routines for use in the QCA7K driver.
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index d3109eb24b4d..7c63baeb3844 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   This module implements the Qualcomm Atheros SPI protocol for
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/etherne=
t/qualcomm/qca_spi.h
index f735ad77402f..d59cb2352cee 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -1,20 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   Qualcomm Atheros SPI register definition.
diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethern=
et/qualcomm/qca_uart.c
index 9adec91f35e9..f911effccfe0 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2017, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   This module implements the Qualcomm Atheros UART protocol for
=2D-
2.34.1


