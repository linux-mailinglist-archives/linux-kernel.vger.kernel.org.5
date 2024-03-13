Return-Path: <linux-kernel+bounces-101105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E6C87A26C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38531C215C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DC71170D;
	Wed, 13 Mar 2024 04:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLyZx9RB"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2EC147
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710305107; cv=none; b=NczgIwS57b2A27T+A8mTbx1e3V8fANIi9yhECV/cyGIO+4DBpkImp5MiVTLoJGtnXQ4cFdNEH/RzrE7H37XL3v8GOHZnAWZBmDeCD/s/QjszlXNMCw/pYL0HnaaVTSgHKWZO/xLV5gvHITu5y07uqZldjUST6MKPSiRyo6vs0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710305107; c=relaxed/simple;
	bh=9KhB8FDCdFYO+YWIrsqRrpS86HEbNgdQ0AxmoAdA4J8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lhSxiSuag6BdPwIbGMNXy3x+jdxGlA6RiSvctOAqzxTbwa8giwIMeUG7sE4vF+MugWBh/x1Poh/oBJA9eQBsBPMJLba/aobwp0sL72f6STcUUb9ZEBgAsFIDuYbBDGp8wJ5iHNTYUVrgzhsXT2GRjeH6x0fIoCfpHwjrT7hnXhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLyZx9RB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41329a665d8so21956775e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710305104; x=1710909904; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k8byZJxMSUx+id+6lvl5IMqP93XziG/dgJmLwqeA4Dw=;
        b=mLyZx9RBwtQXl30aNKLhsKt332FsifDOhpssw3y1ulbYjIfA79sleGHyl5EwqoMTJe
         cUthiLGtzJcNjTE6w2DBicDDwV39BdrhHvfswBQbrkQwmMypMCshOePQvgYZzZVIGWT2
         DUMM8Pi0iNHzyUEi3ZN3xF9+n5keFcq53snwfVlcW2w1UUxWhux9YO3IAX6sy/RbLrap
         0QTJRInd6kg33kjJdeAUYnggs746tD9YQ1pZXZXYfG5T/fnN3LXOlPYzxOojTNSxKWFY
         Xo1t4+aYwg7Gpa3xop+zWbBHfXEKY18Ben9Ut6U/QfHD7/JmG/8niknnNsI+COhvU4Pg
         8nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710305104; x=1710909904;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8byZJxMSUx+id+6lvl5IMqP93XziG/dgJmLwqeA4Dw=;
        b=Vqx7nWX0hsev8r0lF5L51ucphLQz/9U+9WWRe5kj8hXimWArzy05JjtUKOA1OE5YKO
         G5ioQIXP56zyEmYlKxmYOwsa4CNoRLapUAx3Jfh2NCdVcUOFettt+vpNIaj0R04v6+Av
         WgFzUjKGy+2EmptxFkpbut3gtmJdn1ofsy7PY3Y8Pz5LGjVtuLE+Vj9UUKcp7DR0CQk7
         BZnhX/5xWy5Q5Yfp+05K4oH7aWNZBa/QbajhsDsZmB64kBA5Zm3w+pXgTLTqxi6RktjR
         hFiMa7nFPNH4r14ANADCO9Kp6I7B+N2ygvPdUVHqTzOw3iBJxMnpgqYEqjBdBpiVgptU
         L1+A==
X-Forwarded-Encrypted: i=1; AJvYcCWinWRQUFi3I1flOwGtIegJ1tEfbRxM+q3jajPDSYUc3dsM10dpZqVVNAx1fjnniAPa2TCS9YvQDL8lD8ElEma+UP35fUAS8cVZTHWo
X-Gm-Message-State: AOJu0YxsoFUr18gzHW7VSCtTXBoBAkCjM/TZjO4Qlfhrp8tS5pL1jHS+
	Pru3BcqlJF8WIxef8yRvOQlzOnbDcBi5dhwadci+zG/4y42Pi1w8EVF376Vo5MN1IQ==
X-Google-Smtp-Source: AGHT+IGkqx0p4rVxFYIYDInIBZWZyO4WazzTYe+qhKbDXfnbrxGem42x2LXbWUVCZ8lKhbm4OBOarQ==
X-Received: by 2002:a05:600c:4fd3:b0:413:30dc:698a with SMTP id o19-20020a05600c4fd300b0041330dc698amr3700064wmq.25.1710305104005;
        Tue, 12 Mar 2024 21:45:04 -0700 (PDT)
Received: from MOLeToid ([129.0.78.232])
        by smtp.gmail.com with ESMTPSA id u1-20020a05600c138100b00412e5f32591sm986713wmf.28.2024.03.12.21.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 21:45:03 -0700 (PDT)
Date: Wed, 13 Mar 2024 05:45:00 +0100
From: "Felix N. Kimbu" <felixkimbu1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: outreachy@lists.linux.dev
Subject: [PATCH v4] staging: wlan-ng: Rename 'foo' to 'rc' in p80211conv.c
Message-ID: <ZfEvTF7qwYZORGsY@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rename identifier 'foo' to 'rc' in skb_p80211_to_ether() and
skb_ether_to_p80211() to match the common kernel coding style.

Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
---
Changes in v4:
- Remove changelog comments from commit log (AlisonS)

Changes in v3:
- Create a proper new patch revision (AlisonS)
- Use 'rc' instead of 'decrypt_check' (AlisonS)

Changes in v2:
- Fix wrong indentation introduced in v1 (DanC)
- Correct subject to include driver (PhilippH)

 drivers/staging/wlan-ng/p80211conv.c | 30 ++++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211conv.c b/drivers/staging/wlan-ng/p80211conv.c
index 8336435eccc2..7401a6cacb7f 100644
--- a/drivers/staging/wlan-ng/p80211conv.c
+++ b/drivers/staging/wlan-ng/p80211conv.c
@@ -93,7 +93,7 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
 	struct wlan_ethhdr e_hdr;
 	struct wlan_llc *e_llc;
 	struct wlan_snap *e_snap;
-	int foo;
+	int rc;
 
 	memcpy(&e_hdr, skb->data, sizeof(e_hdr));
 
@@ -185,14 +185,14 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
 		p80211_wep->data = kmalloc(skb->len, GFP_ATOMIC);
 		if (!p80211_wep->data)
 			return -ENOMEM;
-		foo = wep_encrypt(wlandev, skb->data, p80211_wep->data,
-				  skb->len,
-				  wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
-				  p80211_wep->iv, p80211_wep->icv);
-		if (foo) {
+		rc = wep_encrypt(wlandev, skb->data, p80211_wep->data,
+				 skb->len,
+				 wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
+				 p80211_wep->iv, p80211_wep->icv);
+		if (rc) {
 			netdev_warn(wlandev->netdev,
 				    "Host en-WEP failed, dropping frame (%d).\n",
-				    foo);
+				    rc);
 			kfree(p80211_wep->data);
 			return 2;
 		}
@@ -265,7 +265,7 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 	struct wlan_llc *e_llc;
 	struct wlan_snap *e_snap;
 
-	int foo;
+	int rc;
 
 	payload_length = skb->len - WLAN_HDR_A3_LEN - WLAN_CRC_LEN;
 	payload_offset = WLAN_HDR_A3_LEN;
@@ -305,15 +305,15 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 				   "WEP frame too short (%u).\n", skb->len);
 			return 1;
 		}
-		foo = wep_decrypt(wlandev, skb->data + payload_offset + 4,
-				  payload_length - 8, -1,
-				  skb->data + payload_offset,
-				  skb->data + payload_offset +
-				  payload_length - 4);
-		if (foo) {
+		rc = wep_decrypt(wlandev, skb->data + payload_offset + 4,
+				 payload_length - 8, -1,
+				 skb->data + payload_offset,
+				 skb->data + payload_offset +
+				 payload_length - 4);
+		if (rc) {
 			/* de-wep failed, drop skb. */
 			netdev_dbg(netdev, "Host de-WEP failed, dropping frame (%d).\n",
-				   foo);
+				   rc);
 			wlandev->rx.decrypt_err++;
 			return 2;
 		}
-- 
2.34.1


