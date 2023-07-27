Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F51765500
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjG0Na3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjG0Na1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:30:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39442723;
        Thu, 27 Jul 2023 06:30:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bbb7c3d0f5so1591325ad.1;
        Thu, 27 Jul 2023 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690464626; x=1691069426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q15IWYuI/5HXw0x/ECyva1u3J08tlhfzm/oK0Hr+ZKE=;
        b=kEIp9RgOgQCaTTw/aecerraAkoEs0C62NJdBO2YnNixfqY0YGhuogCBOWqDkHo4VAF
         S4T3rRczmfOr9MC2Q+7AVGn73DAWOVCGYolD9KedHNb1uPlHk39/58BVm5wHJj4XHmbn
         2ZtUyXAdU9X5hXeGbiB/05wcHo+RlX/ERS7LcS5lTMBe6jydIXxxegosO64dfqnTQ27b
         AwCKxp/4+qQngkJVUxc853IjsxeIC6wo8wR/IeUSEg5WUy9rNnEnD/NvjeP25TsAC3Yx
         3cc9S8IrwH95xEIPJWa4YQ9Eip3XO+bh2xoNgMtnx+kM6jNFWymrBjyMv2u+S0HnyKYa
         367Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690464626; x=1691069426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q15IWYuI/5HXw0x/ECyva1u3J08tlhfzm/oK0Hr+ZKE=;
        b=Plb804pCaljkJFAXbZmyFJu0zsBSoG8oO0sEmpIn34r8IzX5yQ1ckCX6PviVCyKlQr
         tqdTgIkQxjoDkIqa3oCMyqhnGWkq5US4IDOEdhsv59Hf3bFDI4r159yCfUjV6Sj3gIek
         xNTxTIDZbnnhu/kVvn+5EVQyNT6cwxqDkt+2ldzrR9lveDzF+8flIaIhowr7O35gHdiE
         T5P+JNGmwExgRV6DkqI7S4jOIvrNN1FeQJ5IyKw4oMboplpoCbRWZYEVAgtwXE9JllNu
         EOAXpgV8KVqfik5FXFuv8POs0ClTwdGEBPoyWFNe6RP+Z+XFHRDGYXSeLfWvCdSIKbvm
         301w==
X-Gm-Message-State: ABy/qLYbnHhBkaCzBbXTJbNfZb2uJceJDevyywWkwuaDlue5zwtBGXaK
        UPV/s4A/dLnCwI3b8kp2kX174vtNoEQ=
X-Google-Smtp-Source: APBJJlH2t6LvM3rfPgOJFkiOqxs8I29PpPEv4TY2g4fk8qzAa/BBrOgIS38EQ7PpAma2sVL6v4PZMA==
X-Received: by 2002:a17:902:da82:b0:1b8:811:b079 with SMTP id j2-20020a170902da8200b001b80811b079mr6462323plx.0.1690464626000;
        Thu, 27 Jul 2023 06:30:26 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001bb99e188fcsm1610682plo.194.2023.07.27.06.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:30:25 -0700 (PDT)
Date:   Thu, 27 Jul 2023 06:30:22 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Dumazet <edumazet@google.com>,
        Jose Abreu <joabreu@synopsys.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        patchwork-jzi@pengutronix.de
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <ZMJxbrXBeE3WnEUn@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org>
 <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
 <20230726-dreamboat-cornhusk-1bd71d19d0d4-mkl@pengutronix.de>
 <ZME88hOgNug+PFga@hoboy.vegasvil.org>
 <f7849436-8dac-64b1-8ec6-3aced13bee94@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7849436-8dac-64b1-8ec6-3aced13bee94@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:40:51AM +0200, Johannes Zink wrote:
> Hi Richard,
> 
> On 7/26/23 17:34, Richard Cochran wrote:
> > That is great, until they change the data sheet.  Really, this happens.
> 
> I think I don't get your point here.
> 
> That's true for literally any register of any peripheral in a datasheet.
> I think we can just stop doing driver development if we wait for a final
> revision that is not changed any more. Datasheets change, and if they do we
> update the driver.

This is different than normal registers, because the values are a
guess as to what the latency in the hardware design is.

Here is how it works in practice:  Vendor first asks a summer intern to
measure the latency.  Intern does some kind of random measurement, and
that goes into silicon.  One year later, customers discover that the
values are bogus.  Vendor doesn't spin a new silicon revision just for
that.  If vendor is honest, a footnote appears in the errata that the
corrections are wrong.

Thanks,
Richard
