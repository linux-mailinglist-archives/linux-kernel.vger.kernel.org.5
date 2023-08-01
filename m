Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A3C76BF02
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjHAVLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjHAVLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:11:07 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED65F1704;
        Tue,  1 Aug 2023 14:11:00 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BFD6B86A8A;
        Tue,  1 Aug 2023 23:10:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690924252;
        bh=1Vhk04CeLZ9z4SapM+IGF+kWRIENGO6A2rbmvA885pE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vHwdrbPhC0GrWW5GvfH/PsJf94rCHO3YiaH/5388yNg1nGsafvA33aLGWxsp5/rOE
         +oMvaLu/CHncSll1W8q5sC2tC59wG8fXkymoKJQHXawx7+TK2GIvxGuQBJKCnUzAvB
         D2wY1BFOY6nzAEtSmSUOg0s57Lp6j3TWn7ZrDW+c3UeOSFc0TrM0rFfc0C+tBz9Vt3
         yUYfxpHWg69aH1HPYAkYfSGkDDehlewtrqtmYbp+ZAW/yuI7DkYidrar6r4Nvu6E06
         29rwAhzK76re3vofAzW0MKJM/Fytp2QhGjuiWm57LoIDJVJVIg7/RxjAI23IdNjSP6
         Azgkm1Z0QLoEg==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Aug 2023 18:10:52 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: Remove the OV5642 entry
In-Reply-To: <20230801-clobber-attempt-7033f92b3d08@spud>
References: <20230801170015.40965-1-festevam@denx.de>
 <20230801-clobber-attempt-7033f92b3d08@spud>
Message-ID: <8b0e048208220b2ae09eb1a3c52219b9@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 17:47, Conor Dooley wrote:

> Removing it without re-adding it elsewhere does not seem right, since
> there'll now be some undocumented compatibles in the tree, no?

Currently, there is no ov5642 support in the kernel.

If someone adds the support for the ov5642 camera, then a specific 
binding
will have to be created.

I prefer to remove it from trivial-devices to avoid confusion.

As is, it gives a false impression that ov5642 is supported and that it
is a trivial device.

