Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1774B7B5AB2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbjJBTCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238566AbjJBTCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:02:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE94CDA;
        Mon,  2 Oct 2023 12:02:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8357C433C7;
        Mon,  2 Oct 2023 19:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696273363;
        bh=DQV4eoMp9jFD7zvkmtOSYdMnuHNf0VvMoMtfzjO/Ekg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfpmflcifU8vwKb1LuUbnKaLt7SrgFfJ8mi6JgBhDBtu8f6evox6lco6qaN9shTY2
         4hOItYfn1gkGiVOr0F5JLa8Ea/NkLSchdpeBYwVcBdO/4NdxqvlarrrV0jrTTW/hGC
         2ONqqyKkO56gq30zdhOEH39FZrez43YsIqmC4z40vS8rxzNaBocEMbKRAhNla7N440
         ZexOGwcak3iCl6596OPjS6+I1B6hVAoCjaCTg3tIIG5o+l4wmCBlgv1ZtFZcS6rhKW
         7lSvldWLCgz4TM5QkdmgGiET8ifENe7jiuhl17cShv/KTnoxqYDU4nUwlzl3ilg9fT
         3JizYOObasTZw==
Received: (nullmailer pid 2346989 invoked by uid 1000);
        Mon, 02 Oct 2023 19:02:40 -0000
Date:   Mon, 2 Oct 2023 14:02:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ilia.lin@kernel.org, vireshk@kernel.org,
        robh+dt@kernel.org, agross@kernel.org, nm@ti.com,
        andersson@kernel.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH v5 2/4] dt-bindings: opp: opp-v2-kryo-cpu: Document named
 opp-microvolt property
Message-ID: <169627336028.2346949.8537369869669018895.robh@kernel.org>
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930102218.229613-2-robimarko@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 30 Sep 2023 12:21:17 +0200, Robert Marko wrote:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> Document named opp-microvolt property for opp-v2-kryo-cpu schema.
> This property is used to declare multiple voltage ranges selected on the
> different values read from efuses. The selection is done based on the
> speed pvs values and the named opp-microvolt property is selected by the
> qcom-cpufreq-nvmem driver.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes v5:
> * Fix typo in opp items
> 
> Changes v4:
> * Address comments from Rob (meaning of pvs, drop of
>   driver specific info, drop of legacy single voltage OPP,
>   better specify max regulators supported)
> 
>  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

