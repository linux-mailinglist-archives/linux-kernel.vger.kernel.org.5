Return-Path: <linux-kernel+bounces-151553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 125BF8AB06C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947ABB239D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC14130AD4;
	Fri, 19 Apr 2024 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BXrL+qy7"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA612F378;
	Fri, 19 Apr 2024 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535754; cv=none; b=KrZ5O5CgFf9EuGXfMIfA5FRJdYI26a4yMLo4pM+Gp4IISdZABIQ+kHvsTs3/d6d6+jmOinKCe9P2qLAper4gT5+bH6o/6a//aXY4vloSDOYcsMRsM878ip2kvbDvDsZNbH5lHk/cHJHDZsI5qHvuRlo4sXTrjZ7hkC0TRC13KGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535754; c=relaxed/simple;
	bh=lykCOLKqJjRDe+8Set3BA8BLXqNMhZRHNwizcwwY1R8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ubsQzStFZtMGG3SdXh1jWiYmzLexQJSPJTU/NCxmwT4yEjW6MQ3vftUfvxNZm5BxuMyuiwg4cq6ykzOrz2uMkkC6XczYRGBvwgY7oJyMXWec8SYMVMlTM2NHvCkebFPjAoVkUG0OqQ4vZ60BlGDbVxrUTgItRJjlXu6H33UFqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BXrL+qy7; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713535720; x=1714140520; i=markus.elfring@web.de;
	bh=lAS9mTVpLnalSm5EePWLAsejXsUvIKNzzANCk7Zyh88=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BXrL+qy7fKZKSy7vXMNGYc7EmhjKtAJ5OjAQginqikx1Pp94g+yz7C0WAZW9POva
	 Phxn9z46+j3Trvz4xkZp/TchUKQBgINAmCUBTZB+BL6CUaMbReuXDBfAYww1gAvQi
	 vikPRSBVxbCDVZ0Yo9nXMUkFSOQxukR69hLSZ1zsEzsJv6FPZKVuIs5xifpuhx1HJ
	 8YMZ1EuE2YG1fzH0RtxH9ZAOxUW8w3MI6gy42wSOvh9a09uId+uKykhFOI2qelq65
	 KucGTGQtZjtz/vvI6G7xgUMt/zpB1E0RvYkOoIHqnPUNmTGmFJG+xWTuUNyH6XXQl
	 fQakCVTh9NuX0nmHNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mo6O7-1sUcQV2IAN-00mvrD; Fri, 19
 Apr 2024 16:08:40 +0200
Message-ID: <4cff158d-b5ac-4dca-9fbb-626237c1eafe@web.de>
Date: Fri, 19 Apr 2024 16:08:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Haren Myneni <haren@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Nick Child <nnac123@linux.ibm.com>,
 Paolo Abeni <pabeni@redhat.com>, Rick Lindsley <ricklind@linux.ibm.com>,
 Thomas Falcon <tlfalcon@linux.ibm.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ibmvnic: Use -EBUSY in __ibmvnic_reset()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wHaYprIvoklgpYvLAHaNj+zV2sUobvP/1+QGxB/jpFxwfLQ3/qn
 32vCTsyWO3nPL2VCwhbpCMJR8j7UPW1FscxEpo8oGbSL/aAgV/PX6Vpr+VEtuUd39Fl9Wwi
 C04dNziBBise3+TfaEabuRF7AP8kexSpDRo+9sw4iZ7FlHoVp7pytc0thcBAO/GXLQfi2ot
 HsTWBbbb3UTXqwH16qzxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J02Z7QBpCOg=;z+trVArPa8/FGsp1KNJLJcillff
 hRcWIsH8BcyVEgycHUM44aOJtRmtzAwN6ouXaz79v3pTmbM9d7GSKWrRZ6wnWy6i+vKj0djKA
 mU+vnmEikbKvaQBqUWsRZzp1MQxOLxf9psQ01whhYma8tGSY7u92a50OvXBn1IlRsngOvttjY
 qBUZP7pjSVzwwhd3h5QEpCyYQjDC3yDZbs32q8+6WrY7LJcSy7MoDCugO+FpXK/445fvX0Wv5
 2qc1FLNzJac7LHzXbyXOSf6AC54e03yo3XF6qf0YXl1xswPXZQ9D/tt/a8upC9tzNlGm30GxY
 zmJLGtljbL+2GCEzBazjBrhIMvYfEMhTMEury3fLz/7Cef/6VJaNEkTf1H7PfxNMwmxrCSWAN
 SKexmvUTmcZt233uMeQcGmc5S3BroHa9QxNTKot1ydzi6RdYzJxnuv/5DJN8UFa1T3IFXTyyX
 aksxT0fyEwkmLDaB0MRhIhhsYteo88NDd2hIJS9LER0OsRgK0J0HSy0lWELkQmF1NNmxNUSGS
 umUOZ7XUzok6jX+BtbH7DAVIHqgy/IyLQXqBcThg6uHSizSVvXWpbqbztrVByJ1mCyz0bYHWi
 AtAIYC8SQS5xVRj5E33RR/+BT3xkqVBZSvioSSa25LrG2MHLROt0CAPteRYW0nnZAZHDeZVzN
 8WfcVE+jXneHVHX9SGaL5GEHcFNxv6jK1W5TUTD8uqrFnuyRMg81483evRi2wy48cRdUjrbh7
 NW6pVBHGE6UvKCOYRhyE6xE2mjRUg20S+N3bC0houl+NYlZy9c5Gv9/oRUIrvK/w3mR3+VXbs
 CyioRbpVKMsnV52g2zH3aKGPSwPO3629RXSYANKTwAWbE=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 19 Apr 2024 15:46:17 +0200

Add a minus sign before the error code =E2=80=9CEBUSY=E2=80=9D
so that a negative value will be used as in other cases.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm=
/ibmvnic.c
index 5e9a93bdb518..737ae83a836a 100644
=2D-- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3212,7 +3212,7 @@ static void __ibmvnic_reset(struct work_struct *work=
)
 		    adapter->state =3D=3D VNIC_REMOVED) {
 			spin_unlock_irqrestore(&adapter->state_lock, flags);
 			kfree(rwi);
-			rc =3D EBUSY;
+			rc =3D -EBUSY;
 			break;
 		}

=2D-
2.44.0


