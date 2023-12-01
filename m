Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7654801158
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378537AbjLAQiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378410AbjLAQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:37:33 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601C019B9;
        Fri,  1 Dec 2023 08:37:27 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7CAA1C0005;
        Fri,  1 Dec 2023 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701448645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zkn3WcoWgpmwL6HOZQplo2JHjoZL6UnLU3cm1imhSbo=;
        b=JFMrE9igbAfRsBHjn2eHGVHiMZar+QKPiWyK9OTG3p75DXV1HarHSHpQmhsiC+DxHlGO7Y
        EFPQkl1ICPsdMdGysAGOXOmgy5Ez8pavrFYCuuBTrgFYEbQECjrghK/qXSOvruVZMVvOUj
        tAOlSc/eMCexhkirlfEdYgETbEu008DT8cYlflnKTk2I6ZLwi0w89m/s9gYLCcIeV7QikB
        F5Dw8M+TUarzW0meKb7WUVlltV05b/umQIVHXd4PMF7ypDnPcj6iNLfb0l18TQaUUBUIv4
        K4Dvyn1c0wJnOe+hB4udi4esNdBqHVrEjPTUFNFZp1SKN6DZhf2Uk4kz7ImoPw==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Herve Codina <herve.codina@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>
Subject: [RFC PATCH net-next v3 13/13] Documentation: networking: document phy_link_topology
Date:   Fri,  1 Dec 2023 17:37:03 +0100
Message-ID: <20231201163704.1306431-14-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
References: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced phy_link_topology tracks all ethernet PHYs that are
attached to a netdevice. Document the base principle, internal and
external APIs. As the phy_link_topology is expected to be extended, this
documentation will hold any further improvements and additions made
relative to topology handling.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3: New patch

 Documentation/networking/index.rst            |   1 +
 .../networking/phy-link-topology.rst          | 121 ++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 Documentation/networking/phy-link-topology.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index cb435c141794..e472d53f933a 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -87,6 +87,7 @@ Contents:
    operstates
    packet_mmap
    phonet
+   phy-link-topology
    pktgen
    plip
    ppp_generic
diff --git a/Documentation/networking/phy-link-topology.rst b/Documentation/networking/phy-link-topology.rst
new file mode 100644
index 000000000000..d66ee9711ac1
--- /dev/null
+++ b/Documentation/networking/phy-link-topology.rst
@@ -0,0 +1,121 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+PHY link topology
+=================
+
+Overview
+========
+
+The PHY link topology representation in the networking stack aims at representing
+the hardware layout for any given Ethernet link.
+
+An Ethernet Interface from userspace's poing of view is nothing but a
+:c:type:`struct net_device <net_device>`, which exposes configuration options
+trough the legacy ioctls and the ethool netlink commands. The base assumption
+when designing these configuration channels were that the link looked
+something like this ::
+
+  +-----------------------+        +----------+      +--------------+
+  | Ethernet Controller / |        | Ethernet |      | Connector /  |
+  |       MAC             | ------ |   PHY    | ---- |    Port      | ---... to LP
+  +-----------------------+        +----------+      +--------------+
+  struct net_device               struct phy_device
+
+Commands that needs to configure the PHY will go through the net_device.phydev
+field to reach the PHY and perform the relevant configuration.
+
+This assumption falls appart in more complex topologies that can arise when,
+for example, using SFP transceivers (although that's not the only specific case).
+
+Here, we have 2 basic scenarios. Either the MAC is able to output a serialized
+interface, that can directly be fed to an SFP cage, such as SGMII, 1000BaseX,
+10GBaseR, etc.
+
+The link topology then looks like this (when an SFP module is inserted) ::
+
+  +-----+  SGMII  +------------+
+  | MAC | ------- | SFP Module |
+  +-----+         +------------+
+
+Knowing that some modules embed a PHY, the actual link is more like ::
+
+  +-----+  SGMII   +--------------+
+  | MAC | -------- | PHY (on SFP) |
+  +-----+          +--------------+
+
+In this case, the SFP PHY is handled by phylib, and registered by phylink through
+its SFP upstream ops.
+
+Now some Ethernet controllers aren't able to output a serialized interface, so
+we can't directly connect them to an SFP cage. However, some PHYs can be used
+as media-converters, to translate the non-serialized MAC MII interface to a
+serialized MII interface fed to the SFP ::
+
+  +-----+  RGMII  +-----------------------+  SGMII  +--------------+
+  | MAC | ------- | PHY (media converter) | ------- | PHY (on SFP) |
+  +-----+         +-----------------------+         +--------------+
+
+This is where the model of having a single net_device.phydev pointer shows its
+limitations, as we now have 2 PHYs on the link.
+
+The phy_link topology framework aims at providing a way to keep track of every
+PHY on the link, for use by both kernel drivers and subsystems, but also to
+report the topology to userspace, allowing to target individual PHYs in configuration
+commands.
+
+API
+===
+
+The :c:type:`struct phy_link_topology <phy_link_topology>` is a per-netdevice
+resource, that gets initialized at netdevice creation. Once it's initialized,
+it is then possible to register PHYs to the topology through :
+
+:c:func:`phy_link_topo_add_phy`
+
+Besides registering the PHY to the topology, this call will also assign a unique
+index to the PHY, which can then be reported to userspace to refer to this PHY
+(akin to the ifindex). This index is a u32, ranging from 1 to U32_MAX. The value
+0 is reserved to indicate the PHY doesn't belong to any topology yet.
+
+The PHY can then be removed from the topology through
+
+:c:func:`phy_link_topo_del_phy`
+
+These function are already hooked into the phylib subsystem, so all PHYs that
+are linked to a net_device through :c:func:`phy_attach_direct` will automatically
+join the netdev's topology.
+
+PHYs that are on a SFP module will also be automatically registered IF the SFP
+upstream is phylink (so, no media-converter).
+
+PHY drivers that can be used as SFP upstream need to call :c:func:`phy_sfp_attach_phy`
+and :c:func:`phy_sfp_detach_phy`, which can be used as a
+.attach_phy / .detach_phy implementation for the
+:c:type:`struct sfp_upstream_ops <sfp_upstream_ops>`.
+
+UAPI
+====
+
+There exist a set of netlink commands to query the link topology from userspace,
+see ``Documentation/networking/ethtool-netlink.rst``.
+
+The whole point of having a topology representation is to assign the phyindex
+field in :c:type:`struct phy_device <phy_device>`. This index is reported to
+userspace using the ``ETHTOOL_MSG_PHY_GET`` ethtnl command. Performing a DUMP operation
+will result in all PHYs from all net_device being listed. The DUMP command
+accepts either a ``ETHTOOL_A_HEADER_DEV_INDEX`` or ``ETHTOOL_A_HEADER_DEV_NAME``
+to be passed in the request to filter the DUMP to a single net_device.
+
+The retrieved index can then be passed as a request parameter using the
+``ETHTOOL_A_HEADER_PHY_INDEX`` field in the following ethnl commands :
+
+* ``ETHTOOL_MSG_STRSET_GET`` to get the stats strig set from a given PHY
+* ``ETHTOOL_MSG_CABLE_TEST_ACT`` and ``ETHTOOL_MSG_CABLE_TEST_ACT``, to perform
+  cable testing on a given PHY on the link (most likely the outermost PHY)
+* ``ETHTOOL_MSG_PSE_SET`` and ``ETHTOOL_MSG_PSE_GET`` for PHY-controlled PoE and PSE settings
+* ``ETHTOOL_MSG_PLCA_GET_CFG``, ``ETHTOOL_MSG_PLCA_SET_CFG`` and ``ETHTOOL_MSG_PLCA_GET_STATUS``
+  to set the PLCA (Physical Layer Collision Avoidance) parameters
+
+Note that the PHY index can be passed to other requests, which will silently
+ignore it if present and irrelevant.
-- 
2.42.0

