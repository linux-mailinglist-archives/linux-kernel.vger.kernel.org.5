Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09672781E00
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 15:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjHTNtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 09:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjHTNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 09:49:06 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC59186;
        Sun, 20 Aug 2023 06:45:11 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E9986866D9;
        Sun, 20 Aug 2023 15:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1692539107;
        bh=07pf17XIqcF4/faV0+eA61vv8WjjZfA8fHxdCtZpezc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KRrSMOKLOl8CakxM+It5170ARBhJ85MRPH3LyqjnJMNKPzJ6lvB/jAu7cs1X1LCFm
         sl04NSqP/8RFn2iOTewdhx0EcMZSgVp4fwMIgdh+A5On3OB5T8SvEnC75b66LjAjbJ
         8Pd7LYTf6cBLW5CX+aR+rP7Dvvx06YD7qbigZt8sXwkiV3CPcIS2tXHLPEQ5W7YPtG
         QGIdcC4QMGuC39gGkXU6tDFJBjKGlwMXCjYHstGDvTuoWwRhg01tjWh0wuq2uat1zh
         DsIFxbmeEochyZZiILz7OA30Riu3HCjFwIaPiERkbNr+96A52jozgH0goxgMwoPPYT
         3enuyv82/V4gQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 20 Aug 2023 10:45:07 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: Remove the OV5642 entry
In-Reply-To: <c9758ac5-489e-3fda-9ad2-020a9cc15a04@linaro.org>
References: <20230801170015.40965-1-festevam@denx.de>
 <20230801-clobber-attempt-7033f92b3d08@spud>
 <8b0e048208220b2ae09eb1a3c52219b9@denx.de>
 <20230801-dividers-chooser-bd0df9b72d91@spud>
 <f9ab7525f048f3ce814d89f106947c34@denx.de>
 <20230801-selective-strife-b595804cdb27@spud>
 <deb6a4e60f37e9764d24e25b8a6d1d97@denx.de>
 <20230801-reconcile-preamble-8713b6b09ef5@spud>
 <c9758ac5-489e-3fda-9ad2-020a9cc15a04@linaro.org>
Message-ID: <35266529fe09c7df7b49189614355e1f@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2023 05:14, Krzysztof Kozlowski wrote:

> Removal from DTS is rather discouraged, because DTS and these nodes
> could be used in other systems. The best is to fully document the
> device, regardless whether Linux supports it or not.

Right, this was the same recommendation I got from Conor.

Here is v3 that addresses it:

https://lore.kernel.org/linux-media/20230802160326.293420-1-festevam@denx.de/
