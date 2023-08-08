Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B8773D12
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjHHQNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjHHQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:11:38 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B31837D95
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:46:48 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id AA5EEA4E;
        Tue,  8 Aug 2023 08:41:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1691476872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPVA0CYPjEfhlD4HXsls6fAupghB6A81UH9oVrGHeCE=;
        b=I1rFP/sHG0Zc7UxB8+XwU7mfmDmW2fbhAgoGwaWeBIKeY2PB4ln1PdDk4Y3hU5Pyb4IVj0
        nSaKdjU5WjZMY7fXkwEERsDBP23088BYFk/qCUNjhiXysc40X+jJ8sN9tNGVtVulMJN7dL
        URT9L0/Ymptm47MYfZubs87iVH5m6l5qCZAllsdXtxYK/g5lTCZpsRtJ84jmBMhnyZ5lgV
        gjjrCAbhVIj1lv12x8HAEturC2xbC5Y/1/OUFr2eEAZZGfdqI773BKDEtrnQzVE+xCUf0z
        bm/RbsQKiz1aIJMkcgb47hOpLRzjM6OzIGdtrJoaoldnP7xR1yqmElaxDjSu7Q==
MIME-Version: 1.0
Date:   Tue, 08 Aug 2023 08:41:12 +0200
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
Subject: Re: [PATCH v9 3/7] nvmem: core: Do not open-code existing functions
In-Reply-To: <20230808062932.150588-4-miquel.raynal@bootlin.com>
References: <20230808062932.150588-1-miquel.raynal@bootlin.com>
 <20230808062932.150588-4-miquel.raynal@bootlin.com>
Message-ID: <c94105c91cda0a4f7d7c3b5237a0ef3d@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-08-08 08:29, schrieb Miquel Raynal:
> Use of_nvmem_layout_get_container() instead of hardcoding it.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Michael Walle <michael@walle.cc>
