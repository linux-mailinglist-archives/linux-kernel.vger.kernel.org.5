Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8E280BDAE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 23:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjLJW2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 17:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLJW2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 17:28:20 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69A1AD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 14:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oI+PNodiOHGBWKrMYUdT+dmOI/QlUcbx+efPcBlBzUc=;
  b=cmpbLj4M4dlzu8IqgOmKoUtF8+6INL6cZM/AWHG4OLEjTPzpzq1OJDjo
   Wv5VhtYb4lCo5GUHIyC+/9oBOLN1dwbDRBDkJQlrUNPn3OpgGHEp70X+8
   v/r1RoUgJnxMbKcgbX6ZTFWJ4PiiIHezhR9X9um1nwfeL8QZh3AGLVoOS
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,266,1695679200"; 
   d="scan'208";a="73986189"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 23:28:24 +0100
Date:   Sun, 10 Dec 2023 23:28:22 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
cc:     linux-kernel@vger.kernel.org
Subject: Failed to start Raise network interfaces error
Message-ID: <alpine.DEB.2.22.394.2312102317350.3198@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Starting with the commit:

commit 9e479d64dc58f11792f638ea2e8eff3304edaabf
Author: Ivan Vecera <ivecera@redhat.com>
Date:   Fri Oct 13 19:07:51 2023 +0200

    i40e: Add initial devlink support

I am not able to boot normally.  The console shows the message

Failed to start Raise network interfaces

Searching for this message on th internet produces some old discussions
that suggest to look at the file /etc/network/interfaces.  That file on my
system contains:

# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

auto enp24s0f0
iface enp24s0f0 inet dhcp

-------------------------------

The machine in question is part of a cluster, and may be set up in a
specific way.  It actually does boot, in the sense that I get a
login prompt, but it doesn't seem to be reachable from the outside.

The above failure message is followed by a message about the inability to
retrieve a file that is part of the local setup process.  I can find out
more about what is supposed to be done with this file.

Please let me know if there is any further information I can provide.

thanks,
julia
