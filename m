Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1582C774144
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjHHRRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjHHRRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:17:01 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671026A58
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:06:58 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 10C1CA4F;
        Tue,  8 Aug 2023 08:37:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1691476670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7P3ZkUx9dOPM9Vlgqw1znymPDJuXJZyGuV90TuYcBxA=;
        b=HKrciHR5gv4zA3DlkMzlcZOJYJu1VR8kOBjjpNbggxFFkp8t8Vd3lCXpKvdcQP41/iWO9H
        cMGGmBIObtHZXYL0PEFfTgoS82NczF6LPCgwfmGDTBYOnEWc8V5bjz7mHO4Cl5Kw92iRxz
        01nj+dy6h4MTjA/nUAFgulimERKaNn+AnCOduXDeJA1bL3/+WJ1aLIOpSkLr5q2/mm6FG7
        SdmOOkpBq/GuaAucT1DUvHVKtaHYF8ftr0c73ht+rlBTzF3o7lI/Zf3jb9c87DkLQU0yYK
        Vd2+17YeVf7svH8n6EWn2HBlISJjsyVri7ZpxjuGO5gUE4c4KNAnV6MFv6Cm7A==
MIME-Version: 1.0
Date:   Tue, 08 Aug 2023 08:37:49 +0200
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v9 1/7] nvmem: core: Create all cells before adding the
 nvmem device
In-Reply-To: <20230808062932.150588-2-miquel.raynal@bootlin.com>
References: <20230808062932.150588-1-miquel.raynal@bootlin.com>
 <20230808062932.150588-2-miquel.raynal@bootlin.com>
Message-ID: <13efc8af9f5abf28204d1e056a2422b0@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-08-08 08:29, schrieb Miquel Raynal:
> Let's pack all the cells creation in one place, so they are all created
> before we add the nvmem device.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Michael Walle <michael@walle.cc>
