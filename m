Return-Path: <linux-kernel+bounces-129714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74132896ED3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EBA1C26073
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBEC146589;
	Wed,  3 Apr 2024 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnvjN/BM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836D141991;
	Wed,  3 Apr 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147097; cv=none; b=GJb4kOlT3h5xeP4y8OIJlcIxPzZeDQX88LUFOiYzvnmQVAXpBaJpp5/y2HooYcvXnr2Agq3IyIqRtgYtstDclESWE82D1BjAaVtqRO/Hq4o/poB2LbXAKXj6Zy4gjmUjCDNHs0GycSc2U0aavDebEfnkaIU5zQeXPOr4AW/PPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147097; c=relaxed/simple;
	bh=KcgYpc+9CjDQi/NJxVHV2bo7S5xb6FjkQ15XYp0RmCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+QK8eNE5TEMUqFwqq6rhxpXg0RTYbRlc8jWG3Tv3jj3HYfUEJboGqaT8r7lVc32JWaoLUwJwfsdeCMhqGoyy5nDmzqRWwY6g9w7xr0XzE0wE9HxYRVhbWDVxCN6f+pKdAwrZMik9JESX8/74cK7e1I1lzyMnCHKT1DfUpJ8mTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnvjN/BM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A46EC433C7;
	Wed,  3 Apr 2024 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147097;
	bh=KcgYpc+9CjDQi/NJxVHV2bo7S5xb6FjkQ15XYp0RmCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SnvjN/BMqtmaBYJ95X2POqxVnvib0Hcs46hn31TOd76XhAhYvKfJiKcNldggmuqqm
	 517zdgNjgB7eLZt6b5C+o97voT2HYvaBV7oTaE3JdNkYkFkwljRGjPjQSH104EVB7y
	 o2qOc7Xnaec9ss4pc4II/GVmqAtXQ+1/APosntGH0B4XnrTtD1au+44FHYx8wcNfmT
	 w5waF8he/KUouIQKffezkpj/joMyaGMtHoSnMkmAdRFLtIWwa4ffRveU2LIGIR5e3T
	 TC+f5EYpwGcl05mNsKAsLytFareyzB9UKE4TaOcsHhQs1/gKOHtBI0iyIG6azTYfut
	 72lKie0cjUzqQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rrzfl-000000004bT-3UUs;
	Wed, 03 Apr 2024 14:24:58 +0200
Date: Wed, 3 Apr 2024 14:24:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>, luiz.dentz@gmail.com,
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	quic_mohamull@quicinc.com, quic_hbandi@quicinc.com
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
Message-ID: <Zg1KmcFQ3bAJa8qJ@hovoldconsulting.com>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <171146704035.9961.13096206001570615153.git-patchwork-notify@kernel.org>
 <124a7d54-5a18-4be7-9a76-a12017f6cce5@quicinc.com>
 <ZgWLeo5KSLurLDhK@hovoldconsulting.com>
 <c03abbbd-faa5-4fdc-b7c3-5554a90c3419@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c03abbbd-faa5-4fdc-b7c3-5554a90c3419@quicinc.com>

On Fri, Mar 29, 2024 at 12:55:40PM +0530, Janaki Ramaiah Thota wrote:
> On 3/28/2024 8:53 PM, Johan Hovold wrote:
> > On Thu, Mar 28, 2024 at 08:25:16PM +0530, Janaki Ramaiah Thota wrote:

> >> We made this change to configure the device which supports persistent
> >> memory for the BD-Address
> > 
> > Can you say something more about which devices support persistent
> > storage for the address? Is that all or just some of the chip variants?

> Most of the devices support persistent storage, and bd-address storage
> is chosen based on the OEM and Target.

Can you be more specific about which devices support it (or say which do
not)?

Is the address stored in some external eeprom or similar which the OEM
can choose to populate?

> >> So to make device functional in both scenarios we are adding a new
> >> property in dts file to distinguish persistent and non-persistent
> >> support of BD Address and set HCI_QUIRK_USE_BDADDR_PROPERTY bit
> >> accordingly
> > 
> > Depending on the answer to my questions above, you may be able to infer
> > this from the compatible string and/or you can read out the address from
> > the device and only set the quirk if it's set to the default address.
> > 
> > You should not need to add a new property for this.

> As per my understanding, altering the compatible string may cause duplicate
> configuration, right ?

If it's the same device and just a different configuration then we can't
use the compatible string for this.

It seems we need a patch like the below to address this. But please
provide some more details (e.g. answers to the questions above) so I can
determine what the end result should look like.

Johan


From 9719effe80fcc17518131816fdfeb1824cfa08b6 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Thu, 20 Apr 2023 14:10:55 +0200
Subject: [PATCH] Bluetooth: btqca: add invalid device address check

Some Qualcomm Bluetooth controllers lack persistent storage for the
device address and therefore end up using the default address
00:00:00:00:5a:ad.

Apparently this depends on how the controller has been integrated so we
can not use the device type alone to determine when the address is
valid.

Instead read back the address during setup() and only set the
HCI_QUIRK_USE_BDADDR_PROPERTY flag when needed.

Fixes: de79a9df1692 ("Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY")
Fixes: e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD address missing in dts")
Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
Cc: stable@vger.kernel.org	# 6.5
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c   | 33 +++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_qca.c |  2 --
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 19cfc342fc7b..15124157372c 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -15,6 +15,8 @@
 
 #define VERSION "0.1"
 
+#define QCA_BDADDR_DEFAULT (&(bdaddr_t) {{ 0xad, 0x5a, 0x00, 0x00, 0x00, 0x00 }})
+
 int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
 			 enum qca_btsoc_type soc_type)
 {
@@ -612,6 +614,35 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
+static void qca_check_bdaddr(struct hci_dev *hdev)
+{
+	struct hci_rp_read_bd_addr *bda;
+	struct sk_buff *skb;
+	int err;
+
+	if (bacmp(&hdev->public_addr, BDADDR_ANY))
+		return;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Failed to read device address (%d)", err);
+		return;
+	}
+
+	if (skb->len != sizeof(*bda)) {
+		bt_dev_err(hdev, "Device address length mismatch");
+		goto free_skb;
+	}
+
+	bda = (struct hci_rp_read_bd_addr *)skb->data;
+	if (!bacmp(&bda->bdaddr, QCA_BDADDR_DEFAULT))
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+free_skb:
+	kfree_skb(skb);
+}
+
 static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
 		struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
 {
@@ -818,6 +849,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		break;
 	}
 
+	qca_check_bdaddr(hdev);
+
 	bt_dev_info(hdev, "QCA setup on UART is completed");
 
 	return 0;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b266db18c8cc..b621a0a40ea4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1908,8 +1908,6 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
-
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->bdaddr_property_broken)
 			set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
-- 
2.43.2


