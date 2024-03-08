Return-Path: <linux-kernel+bounces-97440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E59876A7D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5BF282CD7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE32B5579F;
	Fri,  8 Mar 2024 18:08:58 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93A340861;
	Fri,  8 Mar 2024 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921338; cv=none; b=N05if2MI0JQ80KPt2VxAwa0pQqeHZr9bCZZUKW+7OiNnRXQnvjWgErTZMIq2Z7XvxDgn9cBNXWBfz/44Cw9+V5UEA8IIRdNWtVSFrtPnZScEZwZbPUKlMbdgBc0vvO0yJ8dnAog8Szb3enSUkK2FY5jJe67DB51xzyX8FWcHsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921338; c=relaxed/simple;
	bh=H81oFEfhqXhD4JoDGucsCDDFcb8LFbVo8RNDJECQhY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+Nl8u1GldQDudP40SHzozeA0KSAsrxe6hJ/hLugvW3cgcoJGmqymQAHLDjJ8AyFsaHZ7kmvz9EgX8TLVc2Q29TF7DW4/Pq2X8ePL0Ln3Kx2PiMXWy5vf/Vflo2sNmr43PPdQG2oc17BHc5eGOURzhzkdWmZfKZSTdjUW88RsKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 957AA1208E5;
	Fri,  8 Mar 2024 18:08:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 4B4DD2002A;
	Fri,  8 Mar 2024 18:08:47 +0000 (UTC)
Message-ID: <67b5221c6ff05cf78070fbbe7f7f06f974b52e3d.camel@perches.com>
Subject: Re: [PATCH] Bluetooth: bfusb: Updated code to follow style guide
From: Joe Perches <joe@perches.com>
To: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>, marcel@holtmann.org, 
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 08 Mar 2024 10:08:46 -0800
In-Reply-To: <20240308162037.100226-1-ayaanmirza.788@gmail.com>
References: <20240308162037.100226-1-ayaanmirza.788@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: npj597os666dgwgduzftnmxcjxes3fez
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 4B4DD2002A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+yGzGzyoaIRu86TK2LukGXJfxCW7uAtmM=
X-HE-Tag: 1709921327-612833
X-HE-Meta: U2FsdGVkX18x0L6aBeTS/bQkIaD0h4VPputVXGjRSk/2rfub5MAAMzGqUk6TgpLALxd77ROoP2pRY/F9JohJNFSWu4AvXQ/BEWOyFWyRBjpf0qITkqR2iZwtZ+aYb95hDFhB7Tz9+aULUUYp/YjNijJPHTbJGNysVNEcV3njSZKHnCLExhr+I74ajrhWpkPF4pKn7GxR3wWrX80/23FLUr2tQ/aTty3IipcUVFNoEbBJHSz5HrEQKUGr9ZVBTakPBnkhktEqJOjXM9olgy328F1EKzfByRUjSHK6hCWHy3KEWcD9cwDmbgHysE4LhfW7

On Fri, 2024-03-08 at 21:50 +0530, Ayaan Mirza Baig wrote:
> Added indendations, removed trailing spaces, added empty lines after decl=
aration.

indendations/indentations.

Do please try to not just mollify checkpatch message bleats
but try to make the code more intelligible.

I think the tests are backwards would better be written
with fewer block indentations and direct returns without
creating used-once temporaries like:

---
 drivers/bluetooth/bfusb.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index cab93935cc7f1..68587424187e6 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -273,33 +273,27 @@ static inline int bfusb_recv_block(struct bfusb_data =
*data, int hdr, unsigned ch
=20
 		switch (pkt_type) {
 		case HCI_EVENT_PKT:
-			if (len >=3D HCI_EVENT_HDR_SIZE) {
-				struct hci_event_hdr *hdr =3D (struct hci_event_hdr *) buf;
-				pkt_len =3D HCI_EVENT_HDR_SIZE + hdr->plen;
-			} else {
+			if (len < HCI_EVENT_HDR_SIZE) {
 				bt_dev_err(data->hdev, "event block is too short");
 				return -EILSEQ;
 			}
+			pkt_len =3D HCI_EVENT_HDR_SIZE + ((struct hci_event_hdr *)buf)->plen;
 			break;
=20
 		case HCI_ACLDATA_PKT:
-			if (len >=3D HCI_ACL_HDR_SIZE) {
-				struct hci_acl_hdr *hdr =3D (struct hci_acl_hdr *) buf;
-				pkt_len =3D HCI_ACL_HDR_SIZE + __le16_to_cpu(hdr->dlen);
-			} else {
+			if (len < HCI_ACL_HDR_SIZE) {
 				bt_dev_err(data->hdev, "data block is too short");
 				return -EILSEQ;
 			}
+			pkt_len =3D HCI_ACL_HDR_SIZE + __le16_to_cpu(((struct hci_acl_hdr *)buf=
)->dlen);
 			break;
=20
 		case HCI_SCODATA_PKT:
-			if (len >=3D HCI_SCO_HDR_SIZE) {
-				struct hci_sco_hdr *hdr =3D (struct hci_sco_hdr *) buf;
-				pkt_len =3D HCI_SCO_HDR_SIZE + hdr->dlen;
-			} else {
+			if (len < HCI_SCO_HDR_SIZE) {
 				bt_dev_err(data->hdev, "audio block is too short");
 				return -EILSEQ;
 			}
+			pkt_len =3D HCI_SCO_HDR_SIZE + ((struct hci_sco_hdr *)buf)->dlen;
 			break;
 		}
=20
@@ -365,9 +359,8 @@ static void bfusb_rx_complete(struct urb *urb)
 			buf   +=3D 3;
 		}
=20
-		if (count < len) {
+		if (count < len)
 			bt_dev_err(data->hdev, "block extends over URB buffer ranges");
-		}
=20
 		if ((hdr & 0xe1) =3D=3D 0xc1)
 			bfusb_recv_block(data, hdr, buf, len);


