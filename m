Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181237B1775
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjI1Jgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjI1Jga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:36:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F045122;
        Thu, 28 Sep 2023 02:36:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED21E1F88F;
        Thu, 28 Sep 2023 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695893786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHX4YnUFhw03++c0If6SuGdIj/sQMUaUI8+AzRNdDNU=;
        b=QpcWtozWmia1N2L+e2do27Se/Iq+Gw36qbVpoBsBAzwxyWPYl7i7WoxKI+q6Y+9wI1TnzQ
        MCjWajhSctwDOIanriw1+jdaMSadBFEGKjOWrL1Todcm2p3ouN6Z5GNrzrWGqmuYtbr4+s
        9pEN84jMdKvNT4mkhTRcPAlRaZL2YuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695893786;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHX4YnUFhw03++c0If6SuGdIj/sQMUaUI8+AzRNdDNU=;
        b=0uwOXGgShEDZDgz01LVXRo4kihx103txiWOT7TyBYkuFV76NEDVr2MGpDam3deTfBs2pZ7
        nti1scvMOMBJjTAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1FF813581;
        Thu, 28 Sep 2023 09:36:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vMDoJBpJFWXucgAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 28 Sep 2023 09:36:26 +0000
Date:   Thu, 28 Sep 2023 11:38:01 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Eliza Balas <eliza.balas@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add support for ADI TDD Engine
Message-ID: <20230928093742.GA7895@alberich>
References: <20230928092804.22612-1-eliza.balas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230928092804.22612-1-eliza.balas@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You've used an odd "To:" field in your E-Mail.
You might have to fix this in future mails.
Have fun.

On Thu, Sep 28, 2023 at 12:28:02PM +0300, Eliza Balas wrote:
> V1 -> V2:
>  * remove label in examples in bindings file
>  * add detailed description of the hardware in bindings file
>  * remove adi_axi_tdd_clk_disable function
>  * remove devm_add_action_or_reset, devm_clk_get, clk_prepare_enable
>    and use instead devm_clk_get_enabled
> 
> Eliza Balas (2):
>   dt-bindings: misc: adi,axi-tdd: Add device-tree binding for TDD engine
>   drivers: misc: adi-axi-tdd: Add TDD engine
> 
>  .../sysfs-bus-platform-drivers-adi-axi-tdd    | 158 ++++
>  .../devicetree/bindings/misc/adi,axi-tdd.yaml |  65 ++
>  MAINTAINERS                                   |   9 +
>  drivers/misc/Kconfig                          |  10 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/adi-axi-tdd.c                    | 780 ++++++++++++++++++
>  6 files changed, 1023 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-drivers-adi-axi-tdd
>  create mode 100644 Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
>  create mode 100644 drivers/misc/adi-axi-tdd.c
> 
> -- 
> 2.25.1
> 

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)
