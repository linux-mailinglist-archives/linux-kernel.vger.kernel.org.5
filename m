Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617AF7F1927
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjKTQxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjKTQxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:53:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA17BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:53:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8550C433C8;
        Mon, 20 Nov 2023 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700499192;
        bh=zs15E1OcNNyL45f6quUF04b0RzI6DpNzgDk0OvGXqlo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rLyu5V0qjSwjcWJyPTIiI6XHa4czbgyciF3ncBh1XimSWk4pTx3IpjRrLk5csBvLm
         OtDtuuw91Z12qAuzTIuxBEyYRVXiyl/esEolinhjDxku9puhgfPMDDZOo5GSkurNAr
         HqLAHQN5w94qHX7zY1I3+UG3R/J/YSIKtC9hbunWZdQFLgvpb7scoFBmlEjqTFnJ3p
         gpDPeILvdzlYe+mRErkdVhTqU4mIc1YuJyIC4lKbiKqOC1JTpFcTdz/32VKALt8IuJ
         RW59sMlqcauIWSbOKhFz4RB56xR4kYrH+8euOTson9wOSLhgbRqEuDUT0UYpmlazHw
         e7/ADxFDIyb9w==
Date:   Mon, 20 Nov 2023 08:53:10 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 5/9] netlink: specs: Modify pse attribute
 prefix
Message-ID: <20231120085310.5ff6efca@kernel.org>
In-Reply-To: <20231120111914.36a5ca73@kmaincent-XPS-13-7390>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
        <20231116-feature_poe-v1-5-be48044bf249@bootlin.com>
        <20231118155702.57dcf53d@kernel.org>
        <20231120111914.36a5ca73@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 11:19:14 +0100 K=C3=B6ry Maincent wrote:
> > You need to run ./tools/net/ynl/ynl-regen.sh =20
>=20
> Ok, should I also send a patch with the newly generated files? Or is it
> something done by the maintainers?

It needs to be part of the series. We don't have very clear guidelines
on how to carry the regeneration. But for small changes like this you
can squash the regenerated code into the spec change.
