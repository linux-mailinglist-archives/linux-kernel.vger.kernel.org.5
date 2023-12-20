Return-Path: <linux-kernel+bounces-6421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2484681989C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565FC1C2509C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83343168CE;
	Wed, 20 Dec 2023 06:29:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14C168A4;
	Wed, 20 Dec 2023 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp73t1703053749tonb8xj4
Received: from HX01040022.powercore.com.cn ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Dec 2023 14:29:07 +0800 (CST)
X-QQ-SSF: A0400000000000B0B000000A0000000
X-QQ-FEAT: cvpDInk2tjX5BPajcFyu8lBYa991EIo5ZSpfNcLacG1cG7G2E3C6Vtt1emMmA
	qrEcp3y0FfgIXj4J/P3b9jrCHl1i2laDbv2JwGv4398TELEzjD83XbZurtAfBuHSfdhpb1W
	xr3zNmWvJ7TRhC4v+ZpQdFBnlZ7KNKRAo1Z67UtiGU/ObNYkTrjcextcX6/yFgd2fwMJM+w
	eEPnyIixtzQA/eFTqT7J+ByZNysmPiHWcYQOIjtgqTyMjxFbIRr3DKU44b6cm5iTa4DMNf3
	8R108bW8PKHZ07+cGn7yjHmWnGHdTySCS91pq/MrcagT9NFE1KQzeV/hc+iujmBBc2wksOc
	c4Q8UzLvg8R+N4F3hpC9B0Ow0456+0QNDDI6LMmNXWJlRyqHdgoyl7c3y3WE0JHXO6vjK/o
	Fcfdb2zwpeH3j03ji9tF/Q==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6145391181880478621
From: "JiaLong.Yang" <jialong.yang@shingroup.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: 2738078698@qq.com,
	"JiaLong.Yang" <jialong.yang@shingroup.cn>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Docs/zh_CN: Fix the meaning of DEBUG to pr_debug()
Date: Wed, 20 Dec 2023 14:28:21 +0800
Message-Id: <20231220062822.16168-1-jialong.yang@shingroup.cn>
In-Reply-To: <202312201105408639401@shingroup.cn>
References: <202312201105408639401@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

We know the macro DEBUG will make pr_debug() save the formatted
string into final binary. So the translation is a little wrong.

Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
---
 Documentation/translations/zh_CN/core-api/printk-basics.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/core-api/printk-basics.rst b/Documentation/translations/zh_CN/core-api/printk-basics.rst
index 59c6efb3fc41..cafa01bccff2 100644
--- a/Documentation/translations/zh_CN/core-api/printk-basics.rst
+++ b/Documentation/translations/zh_CN/core-api/printk-basics.rst
@@ -100,7 +100,7 @@ printk()的用法通常是这样的::
 
 为了调试，还有两个有条件编译的宏：
 pr_debug()和pr_devel()，除非定义了 ``DEBUG`` (或者在pr_debug()的情况下定义了
-``CONFIG_DYNAMIC_DEBUG`` )，否则它们会被编译。
+``CONFIG_DYNAMIC_DEBUG`` )，否则它们不会被编译。
 
 
 函数接口
-- 
2.25.1


