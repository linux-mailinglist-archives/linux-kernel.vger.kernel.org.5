Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A257CE5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbjJRSJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344738AbjJRSIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:08:53 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0567E126;
        Wed, 18 Oct 2023 11:00:11 -0700 (PDT)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
        (envelope-from <laforge@gnumonks.org>)
        id 1qtApx-00EjDB-RY; Wed, 18 Oct 2023 20:00:05 +0200
Received: from laforge by nataraja with local (Exim 4.97-RC2)
        (envelope-from <laforge@gnumonks.org>)
        id 1qtAnC-00000002j2L-0xli;
        Wed, 18 Oct 2023 19:57:14 +0200
Date:   Wed, 18 Oct 2023 19:57:14 +0200
From:   Harald Welte <laforge@gnumonks.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     takeru hayasaka <hayatake396@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        osmocom-net-gprs@lists.osmocom.org
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <ZTAceqxFSmL-jFuw@nataraja>
References: <20231012060115.107183-1-hayatake396@gmail.com>
 <20231016152343.1fc7c7be@kernel.org>
 <CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
 <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
 <20231017164915.23757eed@kernel.org>
 <CADFiAc+OnpyNTXntZBkDAf+UfueRotqqWKg+BrApWcL=x_8vjQ@mail.gmail.com>
 <20231018103703.41fd4d9b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018103703.41fd4d9b@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On Wed, Oct 18, 2023 at 10:37:03AM -0700, Jakub Kicinski wrote:
> Harald went further and questioned use of the same IP addresses for 
> -U and -C traffic, but even within one endpoint aren't these running
> on a different port? 

yes.

> Can someone reasonably use the same UDP port for both types of traffic?

I don't think so.  In the entire 3GPP protocol world, the UDP port numbers
for GTP-U and GTP-C are fixed.  The various signaling protocols allow you to
communicate the IPv4/v6 address and TEID of tunnel endpoints, but never allow
you to communicate the port number - which hence must always be the well-known port
(2123 for GTP-C + 2152 for GTP-U).

Of course somebody could do whatever they want in some kind of internal interface
not required to interoperate with any other equipment/implementation/operator, but
I'd consider it not falling in your question of "reasonable use".

Regards,
	Harald

-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
