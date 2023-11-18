Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC7B7F03AF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 00:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjKRX5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 18:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRX5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 18:57:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F4A93
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 15:57:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA86C433C7;
        Sat, 18 Nov 2023 23:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700351824;
        bh=hGn1k8/XkatnSDQ8GMUnDRJ29L047zzWy1lubfc7N5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cEBhBVl1xLvk5oXDeO/hQsnG6k4BMSkng9WgFXyzA6Em+iJBBiZzeRd+eoREKiml+
         d06lRE2o95iCw2/2hzJfi9vil93N32wNvKiRSlwHAQY0BOw7z5E5PAzQt6wah13/qr
         jzLQTmjZH4cRjFjjUznCZQ3zgFtkSmeesqlcUgh2aSQ8NRZmSb3+2JkqoEyccxe3RV
         wqZHR1rMUtQM88jaUrs0a530i3Mqth2y2d4M3/iYYhFGQOdFmJKlF5GIUe5NhhUZTT
         Y+Ido//Q8rYzKE9kvZlNG7AKP9GPcy0fNPNSUYr4E5VROOBw496GITGuY68RvQNeDj
         8sE6m6D/B+AMA==
Date:   Sat, 18 Nov 2023 15:57:02 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
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
Message-ID: <20231118155702.57dcf53d@kernel.org>
In-Reply-To: <20231116-feature_poe-v1-5-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
        <20231116-feature_poe-v1-5-be48044bf249@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 15:01:37 +0100 Kory Maincent wrote:
> Remove podl from the attribute prefix to prepare the support of PoE pse
> netlink spec.

You need to run ./tools/net/ynl/ynl-regen.sh
