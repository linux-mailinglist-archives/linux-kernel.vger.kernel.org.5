Return-Path: <linux-kernel+bounces-68467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8CF857A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12B51F24B96
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAA8535C7;
	Fri, 16 Feb 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="JuAuUjBx"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22372535A5;
	Fri, 16 Feb 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080449; cv=none; b=McWPEbQX6yGebo6h/8yK+/jWho500Lsm27IZ5S/hKCu3X3gdqmYEccoBogRT+OkVRF7r8E4o1nQbvWos0khha5TMuol+q1aiTIzC63rj4gnT6lNhKBD7yiC03UPB+ol/nPh2RaJoRr8LeDCqzXd5SY0gc3yaGbJjstZ/KN21nGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080449; c=relaxed/simple;
	bh=Q5R/8SUslPHdWj3Qf/Y7JhyVUt5V40WPulzuQB+vQKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aC7JBbSqUgKGWYgwb34Fiuhv/dlmE/Gzn/QgaTj+HGa/y2QIxdZzE4FVSp0fooQGBEiHAkdcD86Z1mu+jSO8pNWnMmlNGoY2a57IR6HLmx/I/h5H8nObY1MPUnyRdhGKKFWP6hrzKOoEbND9k6ARpBmTrF+k8Sk5p4g8m3PDF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=JuAuUjBx; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7BCE8FF805;
	Fri, 16 Feb 2024 10:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1708080444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjAwS62w0l3U2ufG6A+rcoAlJXJZ7s34vp7zsEJzR6k=;
	b=JuAuUjBxIIQs8YIHT6/SY+sh1Qstl0s6NM4ZJGG4RmqjgRnmnMc+U1S2yv4buFIPFDe33Y
	yuydW7zosZKH68q+ARea34tJyLxBng0YqYfxdoJJzwa0Aqb172o3PCumZyfnYLvzpAZTla
	GgXoFgpnUoQ8M0713psxCKJy4oRdpZtJLa0zgI2cktxY6h1hlOkuk8Ksfcus2iRPTnFDSc
	VimVynzo+hOSItc0o9iecaEjE7kWpAIEMzgZ1xjngFya3sJkqdyT3e08L8cda5T7M1mZfj
	fLpGaBH7Hd5uznBDntDZSiy4/DOFKAXilTJpDm4cIko5bZqRxiyRxD+WpOmI5w==
Message-ID: <af66e632-071f-4c39-ab38-62782e6eff05@arinc9.com>
Date: Fri, 16 Feb 2024 13:47:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net RFC] net: dsa: mt7530: fix link-local frames that
 ingress vlan filtering ports
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <65bbf40d.170a0220.a87f4.becdSMTPIN_ADDED_BROKEN@mx.google.com>
 <65bbf40d.170a0220.a87f4.becdSMTPIN_ADDED_BROKEN@mx.google.com>
 <20240201232619.nsmm7lvafuem2gou@skbuf>
 <20240216012445.em247rxfjnyufwm5@skbuf>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240216012445.em247rxfjnyufwm5@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 16.02.2024 04:24, Vladimir Oltean wrote:
> On Fri, Feb 02, 2024 at 01:26:19AM +0200, Vladimir Oltean wrote:
>> On Thu, Feb 01, 2024 at 10:13:39PM +0300, Arınç ÜNAL via B4 Relay wrote:
>>> One remaining limitation is that the ingress port must have a PVID assigned
>>> to it for the frame to be trapped to the CPU port. A PVID is set by default
>>> on vlan aware and vlan unaware ports. However, when the network interface
>>> that pertains to the ingress port is attached to a vlan_filtering enabled
>>> bridge, the user can remove the PVID assignment from it which would prevent
>>> the link-local frames from being trapped to the CPU port.
>>>
>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>> ---
>>> I couldn't figure out a way to bypass VLAN table lookup for link-local
>>> frames to directly trap them to the CPU port. The CPU port is hardcoded for
>>> MT7530. For MT7531 and the switch on the MT7988 SoC, it depends on the port
>>> matrix to choose the CPU port to trap the frames to. Port matrix and VLAN
>>> table seem to go hand in hand so I don't know if this would even be
>>> possible.
>>>
>>> If possible to implement, link-local frames must not be influenced by the
>>> VLAN table. They must always be trapped to the CPU port, and trapped
>>> untagged.
>>
>> Isn't this, in effect, what the "Leaky VLAN Enable" bit does?
> 
> Hm? Any news on this? I suppose this was the reason for submitting the
> otherwise ok patch as RFC?

I was just finalising my response. I wanted to study the switch a little
bit so that I could give a better response than "the leaky VLAN option
doesn't do anything :/".

 From what I understand, with the leaky VLAN option enabled, the frame won't
possibly be dropped at the VLAN table lookup procedure. This is useless in
this case because with commit ("net: dsa: mt7530: drop untagged frames on
VLAN-aware ports without PVID"), PVC.ACC_FRM of port without PVID set on
software is set to TAGGED to prevent untagged frames ingressing through
this port from being forwarded. So what we need instead is to allow
untagged frames to be forwarded.

With PVC.ACC_FRM set to ALL, all VLAN-untagged frames will be forwarded
[1]. With that, we need to configure the switch in a way that only the
link-local frames will be forwarded. I have yet to find a way to achieve
this.

Before that, here's how I think the switching procedure works.

VLAN-tagged/VLAN-untagged frame ingresses through port

1. Address Table Learning

    The switch will add an entry to the MAC address table; the source
    address as ADDRESS, the ingress port as PORT / FILTER, [if tagged
    frame and PVC.VLAN_ATTR = USER: VID on the VLAN tag; if untagged frame
    (and PVC.VLAN_ATTR = USER or TRANSPARENT), or PVC.VLAN_ATTR =
    TRANSPARENT (and untagged or tagged frame): PPBV1.G0_PORT_VID] as CVID.

2. Address Table Lookup Procedure

    For unicast frame type, the switch will look up the destination address
    as ADDRESS on the MAC address table. If the destination address does not
    match a MAC address table entry, the ports set on MFC.UNU_FFP will be
    the forwardable ports.

    For broadcast frame type, the ports set on MFC.BC_FFP will be the
    forwardable ports.

    For non-IP-multicast multicast frame type, the ports set on MFC.UNM_FFP
    will be the forwardable ports.

3. If PVC.ACC_FRM is set to TAGGED, the switch will drop VLAN-untagged
    frames.

4. If PCR.PORT_VLAN is set to PORT_MATRIX mode, skip to step 6.

5. VLAN Table Lookup Procedure

    The switch will look up the VID on the VLAN table. If the frame is
    VLAN-untagged, the VID will be PPBV1.G0_PORT_VID of the ingress port. If
    entry with the VID does not exist on the VLAN table entry, on SECURITY
    and CHECK modes, the switch will drop the frame. On FALLBACK mode, the
    switch won't drop the frame.

    The switch will look up the ingress port on PORT_MEM on the VLAN table
    entry that matches the VID. If the ingress port is not set on PORT_MEM,
    on SECURITY mode, the switch will drop the frame. On FALLBACK and CHECK
    modes, the switch won't drop the frame.

6. The switch will look up the ports set on PCR.PORT_MATRIX to narrow down
    the ports to forward the frame to. The ingress port will be excluded.

7. VLAN Tag Egress Procedure

    The EG_TAG bit for frames:

    PPPoE Discovery_ARP/RARP: PPP_EG_TAG and ARP_EG_TAG in the APC register.
    IGMP_MLD: IGMP_EG_TAG and MLD_EG_TAG in the IMC register.
    BPDU and PAE: BPDU_EG_TAG and PAE_EG_TAG in the BPC register.
    REV_01 and REV_02: R01_EG_TAG and R02_EG_TAG in the RGAC1 register.
    REV_03 and REV_0E: R03_EG_TAG and R0E_EG_TAG in the RGAC2 register.
    REV_10 and REV_20: R10_EG_TAG and R20_EG_TAG in the RGAC3 register.
    REV_21 and REV_UN: R21_EG_TAG and RUN_EG_TAG in the RGAC4 register.

    For other frames, one of these options set the earliest in this order
    will apply to the frame:

    EG_TAG in the address table.
    EG_TAG in the PVC register.
    EG_CON and EG_TAG per port in the VLAN table.
    EG_TAG in the PCR register.

Frame egresses through port(s)

Clarifications:

- MAC SA of untagged frames are learned even with PVC.ACC_FRM of the
   ingress port set to TAGGED. That's why the 3rd step comes after the 1st
   step. Untagged frames are still dropped with PCR.PORT_VLAN of the ingress
   port set to PORT_MATRIX mode. That's why the 3rd step comes before the
   4th step. I can't prove untagged frames are dropped before address table
   lookup.

- IP multicast frames are looked up on "Destination IP Address Table", and
   "Source IP Address Table" if IGMPv3/MLDv2. I haven't studied these yet so
   I didn't explain processing IP multicast frames.

With VLAN-untagged frames forwarded, frames will leak to non-ingress ports
[2].

We can at least egress non-link-local frames tagged [3]. As stated above,
PVC_EG_TAG does not apply to link-local frames.

If we could disable unicast frame forwarding completely, and unknown
(broadcast, multicast) frame flooding for frames with certain VID, we could
set PVID to 4095 when there's no PVID on software, and disable them for VID
4095 frames. I don't believe this operation exists on this switch IP.

In conclusion, these are the options:
- Let frames tagged with VID 0 leak to non-ingress ports for the benefit
   of always trapping link-local frames.
- Find a way to prevent the leaks.
- Keep disallowing untagged frames from being forwarded, link-local frames
   won't always be trapped.

I would love your input as someone who has much more experience than I do.

[1]
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index eab1f52e7eb3..1e160b6eb035 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1699,11 +1699,6 @@ mt7530_port_vlan_add(struct dsa_switch *ds, int port,
  		/* This VLAN is overwritten without PVID, so unset it */
  		priv->ports[port].pvid = G0_PORT_VID_DEF;
  
-		/* Only accept tagged frames if the port is VLAN-aware */
-		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
-			mt7530_rmw(priv, MT7530_PVC_P(port), ACC_FRM_MASK,
-				   MT7530_VLAN_ACC_TAGGED);
-
  		mt7530_rmw(priv, MT7530_PPBV1_P(port), G0_PORT_VID_MASK,
  			   G0_PORT_VID_DEF);
  	}

With this and the commands below, link-local frames will be trapped to the
CPU port.

ip l add br0 type bridge vlan_filtering 1 && \
ip l set lan1 master br0 && \
ip l set br0 up && \
ip l set lan1 up && \
bridge v a vid 1 dev lan1 && \
tcpdump -X -i eth0

[2]
Enabled ports: P0-P4 as user & P6 as CPU

On VLAN filtering bridge: P0, P1
On VID 0:                 P0, P1 (no PVID on software)
                           P2, P3, P4 (standalone)
                           P6 (CPU port)

Address table:
PORT / FILTER of VID 0 entry ADDRESS PC0: 00000001 (destination port is P0)
PORT / FILTER of VID 0 entry ADDRESS PC1: 00000010 (destination port is P1)
[...]
PORT / FILTER of VID 0 entry ADDRESS SoC: 01000000 (destination port is P6)

VLAN table:
PORT_MEM of VID 0 entry: 01011111

P0 & P1 registers:
PVC.ACC_FRM = ALL
PPBV1.G0_PORT_VID = 0
PCR.PORT_VLAN = SECURITY
PVC.VLAN_ATTR = USER
PCR.PORT_MATRIX = 01000011

VLAN egress configuration:
EG_TAG of VID 0 address table entry ADDRESS PC0 & PC1 = SYSTEM_DEFAULT
P0 & P1 PVC.EG_TAG = SYSTEM_DEFAULT
EG_CON/[EG_TAG per port] of VID 0 VLAN table entry = EG_TAG (TAGGED for P0
& P1, STACK for P6)
P0 & P1 PCR.EG_TAG = SYSTEM_DEFAULT

Global registers:
MFC.BC_FFP =  01011111
MFC.UNU_FFP = 01011111

Broadcast untagged frame ingresses through P0:
1. An entry is added to the MAC address table. P0 as destination port, 0 as
    CVID.
2. MFC.BC_FFP is used to set the forwardable ports, 01011111.
3. Untagged frame is allowed.
4. VLAN table is not skipped.
5. VLAN table entry with 0 as VID exists, the frame is allowed. Ingress
    port is set on PORT_MEM, the frame is allowed.
6. Bitwise AND with PCR.PORT_MATRIX results in 01000011. Bitwise AND with
    ~00000001 (ingress port) results in 01000010. Frame egresses through P1
    & P6.
7. EG_TAG per port of VID 0 VLAN table entry applies. Frame eggresses
    tagged through P1, stacked through P6.

Unicast untagged frame with destination address PC1 ingresses through P0:
1. An entry is added to the MAC address table. P0 as destination port, 0 as
    CVID.
2. Destination address matches an entry. PORT / FILTER of the matching
    entry is used to set the forwardable ports, 00000010.
3. Untagged frame is allowed.
4. VLAN table is not skipped.
5. VLAN table entry with 0 as VID exists, the frame is allowed. Ingress
    port is set on PORT_MEM, the frame is allowed.
6. Bitwise AND with PCR.PORT_MATRIX results in 00000010. Bitwise AND with
    ~00000001 (ingress port) results in 00000010. Frame egresses through P1.
7. EG_TAG per port of VID 0 VLAN table entry applies. Frame eggresses
    tagged.

Unicast untagged frame with unknown destination address ingresses through
P0:
1. An entry is added to the MAC address table. P0 as destination port, 0 as
    CVID.
2. Destination address doesn't match an entry. MFC.UNU_FFP is used to set
    the forwardable ports, 01011111.
3. Untagged frame is allowed.
4. VLAN table is not skipped.
5. VLAN table entry with 0 as VID exists, the frame is allowed. Ingress
    port is set on PORT_MEM, the frame is allowed.
6. Bitwise AND with PCR.PORT_MATRIX results in 01000011. Bitwise AND with
    ~00000001 (ingress port) results in 01000010. Frame egresses through P1
    & P6.
7. EG_TAG per port of VID 0 VLAN table entry applies. Frame eggresses
    tagged through P1, stacked through P6.

[3]
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index eab1f52e7eb3..2c7c5eaba4b6 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1699,10 +1699,10 @@ mt7530_port_vlan_add(struct dsa_switch *ds, int port,
  		/* This VLAN is overwritten without PVID, so unset it */
  		priv->ports[port].pvid = G0_PORT_VID_DEF;
  
-		/* Only accept tagged frames if the port is VLAN-aware */
+		/* Egress leaks tagged */
  		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
-			mt7530_rmw(priv, MT7530_PVC_P(port), ACC_FRM_MASK,
-				   MT7530_VLAN_ACC_TAGGED);
+			mt7530_rmw(priv, MT7530_PVC_P(port), PVC_EG_TAG_MASK,
+				   PVC_EG_TAG(MT7530_VLAN_EG_TAGGED));
  
  		mt7530_rmw(priv, MT7530_PPBV1_P(port), G0_PORT_VID_MASK,
  			   G0_PORT_VID_DEF);
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 3ef9ed0163a1..5ff9a30ef4de 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -259,6 +259,7 @@ enum mt7530_port_mode {
  enum mt7530_vlan_port_eg_tag {
  	MT7530_VLAN_EG_DISABLED = 0,
  	MT7530_VLAN_EG_CONSISTENT = 1,
+	MT7530_VLAN_EG_TAGGED = 6,
  };
  
  enum mt7530_vlan_port_attr {

Arınç

