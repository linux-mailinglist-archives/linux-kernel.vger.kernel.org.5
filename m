Return-Path: <linux-kernel+bounces-88601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC2686E404
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1416D1C2085A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FBF7002F;
	Fri,  1 Mar 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kB0AcZcq"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FEF3A8E3;
	Fri,  1 Mar 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305492; cv=none; b=boStXpE3+EqKnevvRjjAeE1bGa9AlKBY4oEuey2tIzomjndNNC/CtsWjwQD2acxiWxdz+6D0YgXEzxkFwQErvMwxLyPN66fLR8qbT7WJbFeS3wCmjh+IJWpUtIhJJja7CwYBtNywI4XlG1F9qYjkpIBbQBudsoU49bJk8QEawMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305492; c=relaxed/simple;
	bh=AfZgX4PFBnRALIWRND3UH5sbBTC68YgJey8bmNSd1Gs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Vg6Y4oWloRv/uNM3fq/RhVnpLiO0eZ6TX6SZQw6slBpjQseFhrZDNCtLrif4A5x5cos0H5elRK9J6hHesalgfAw6jlEVCjTofNxjp1UZHP9bfirOFYfucA0q/FICUqIPqUj15nrbIpsDPi6iPFyeem/8d8hf1bN09MfDRW3IYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kB0AcZcq; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709305453; x=1709910253; i=markus.elfring@web.de;
	bh=AfZgX4PFBnRALIWRND3UH5sbBTC68YgJey8bmNSd1Gs=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=kB0AcZcqRZbdRoRrzDoJeHiCdbwVp3/Vk4xRpQz1btthq8uEUSqqq8vpKxmc4eOx
	 gQ6IMkGjXILh/SgPG/Num9rPpd1+31wAsJ/FLzEY8V8Y1vyEMiIjpjtZ/BrLawcFT
	 ma3Z0dBCr/rVJe4h7Gwou8YFKhCQc1MEHTFW5m5uGV9JxNh3ROp2fwvWlxEKHn0O5
	 OYqMqJVsZOvULV5VxESoaylgu3xeFOSXlHJXw1i0c553QLsT095qa6FqHqz5eMn/h
	 Fw1lbq7u+PF2IxlaxshFKovge8CvTPMDiMcOzEd+ZwJ/mhhdUS6rPKfDzTPwzamtl
	 4Zg5ctsHIaLzOKaTzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SL5-1qjnKk1Y1n-013yV0; Fri, 01
 Mar 2024 16:04:13 +0100
Message-ID: <9a2e5053-07ec-4a11-bef4-7a8b0f80f740@web.de>
Date: Fri, 1 Mar 2024 16:04:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jijie Shao <shaojijie@huawei.com>,
 Paolo Abeni <pabeni@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Yonglong Liu <liuyonglong@huawei.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] net: hns: Use common error handling code in hns_mac_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g/zMKCWXPxqqIkYYxVNWWZBfee+4OeC3/qmzN2FMrL1NfKaGZqe
 KY8HnAlhIcoVZSvmAK1KFTZJN8S8cQXau9bTbnjlHnQCSSbBz/mwT3M0roMmr0dlVnWUaVu
 UCI3sGgoykx072KGYcOGYAXVgqZaDtzzffG94L3CK++C65Fo31Td19w+aEmzL4Pogdgi9pb
 VRJ8OvwC4EoKWR9bSYmOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TE01qw5ckh4=;A0WHE5wXuRiOqFiUs6hqO50bKta
 8f9mN9shdG5P4elUuXaLtvwSRKFv4UNq3Ylyx2yJXlJBdWeRknqHyMMN2H6xM+SdlgcUkjw6W
 qc9XHEE3VM6b5I+4orgzEvn2Vr1wsX9mVvkpDCphCMd7GtB3NAVGxqwMkSRmEebcUoUyTsfnU
 DygQ13QK+xSZi1a7BRsP730efadTXmqd5zXRaXlCBrYIOSJ3tSBfMt3RaftBDBwS+QOFjVq1J
 GKCSOhs4NwRzpVnz+5/WJkkfgCsVNPU6br9QdSjI3KrXEW6wT6RNUdz0GswDJ9LBRAxKbZV9G
 l2zGqtd+L7gqvKdSY3lLQE9bHTH5cHwKxJpHdJ3IFZ1aquTzs3kUDrIXbEFbjnqKbnqIOLhr0
 r3NSazBpvw+PU2pDu/EBrKMsTqciBL97IgJlD4gfXTtcRcaFSC9qwr16CWZC88siCTGK2GZr6
 VNYkBeIy/rGKH3L7MX+bp762higr/y/cqjvpSVt1SrmHkQw05A4m2v0uq2te698arC0RgDcZ6
 ZxWcHKdhpB/p3pRY7sIr/YqY8Si2nrl6ioCAMnzgra/BEDELqp3l/+gXvM6n4TAmjOmLzHhYR
 oFEcyWEzYGTUiDY7Kge7h99faS3P4+lEmJGX1xK2Vkq81eQNqDp3CigyO7Mv1X/po1s6dr/nh
 uL+dB2UBWmggr/GCAe4xbaDeGjKVoFqGMKkTEFBQSaWmpwi3xxVkV+jQFtnGfC30W1QMRllJb
 1iQoCSpJ07x8qBLB7j9eHFJHC6yEmjtCrPNoSpYImHB8zRlBbXz2VbhzNUB3JhNtI5J3N3z7v
 l/IWRf+7yls15iRGg39lBVSbqcDFL9JT9Bepiu1bmCmAg=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 1 Mar 2024 15:48:25 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/n=
et/ethernet/hisilicon/hns/hns_dsaf_mac.c
index f75668c47935..a4919aad45b6 100644
=2D-- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -1094,22 +1094,21 @@ int hns_mac_init(struct dsaf_device *dsaf_dev)
 	device_for_each_child_node(dsaf_dev->dev, child) {
 		ret =3D fwnode_property_read_u32(child, "reg", &port_id);
 		if (ret) {
-			fwnode_handle_put(child);
 			dev_err(dsaf_dev->dev,
 				"get reg fail, ret=3D%d!\n", ret);
-			return ret;
+			goto put_fwnode;
 		}
 		if (port_id >=3D max_port_num) {
-			fwnode_handle_put(child);
 			dev_err(dsaf_dev->dev,
 				"reg(%u) out of range!\n", port_id);
-			return -EINVAL;
+			ret =3D -EINVAL;
+			goto put_fwnode;
 		}
 		mac_cb =3D devm_kzalloc(dsaf_dev->dev, sizeof(*mac_cb),
 				      GFP_KERNEL);
 		if (!mac_cb) {
-			fwnode_handle_put(child);
-			return -ENOMEM;
+			ret =3D -ENOMEM;
+			goto put_fwnode;
 		}
 		mac_cb->fw_port =3D child;
 		mac_cb->mac_id =3D (u8)port_id;
@@ -1148,6 +1147,10 @@ int hns_mac_init(struct dsaf_device *dsaf_dev)
 	}

 	return 0;
+
+put_fwnode:
+	fwnode_handle_put(child);
+	return ret;
 }

 void hns_mac_uninit(struct dsaf_device *dsaf_dev)
=2D-
2.44.0


