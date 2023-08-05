Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD3E770D8A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjHEDg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEDg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191414ED7;
        Fri,  4 Aug 2023 20:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7EC662181;
        Sat,  5 Aug 2023 03:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F714C433C8;
        Sat,  5 Aug 2023 03:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691206615;
        bh=Qy59dwEG2sEBKJ3uVrLEgSsdsjiZwNwzGCh/053dPdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNGWCUeixkpzWHdK9GIGvteKTCydmouSQP1Eb72m8cJgbMVe5WgQGc9DIziQsI+C1
         PrtfH7DteoT0+nH/rzznc6aaigo776+iN+M7sBzMU+hKJV6GLkItmTkP5UJd2VKTcH
         Cukd/yuOLLluICossH7smU54svWy/5anSGCPXwWThtlKBaI8QSZeCBuQdUNEvIzl1b
         dxMspzfDw5A1lY26Ok9+ydjv9iU+0pS7z7RYGjcV2B64Y98xb1YjnUh5ZNU8M08s/E
         wfZDvXiLgtFojSxoXiOiPG2e3fogdAs9k7/SI7SSTw2y4pUA6/nP2MOqVRHyY08+q2
         090W11bgrpMwA==
Date:   Fri, 4 Aug 2023 20:39:53 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 03/25] gunyah: Common types and error codes for
 Gunyah hypercalls
Message-ID: <r3rwlnkfh5r6n3ijtkdtufwgthclbka3yasvb7inovnn3vt4m2@qnxfrhiublf7>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-4-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-4-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:31AM -0700, Elliot Berman wrote:
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
[..]
> +/******************************************************************************/
> +/* Common arch-independent definitions for Gunyah hypercalls                  */
> +#define GH_CAPID_INVAL	U64_MAX
> +#define GH_VMID_ROOT_VM	0xff
> +
> +enum gh_error {

"gh_" happens to be an unused prefix in the Linux kernel, but I find it
to be an unnatural abbreviation of "gunyah".

I would therefor prefer to have it expanded to "gunyah" for all
functions, macros and data types throughout the implementation.

Regards,
Bjorn
