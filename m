Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BBF77115C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjHESQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHESQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:16:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB271BD;
        Sat,  5 Aug 2023 11:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31B4960D41;
        Sat,  5 Aug 2023 18:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3097C433C8;
        Sat,  5 Aug 2023 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691259410;
        bh=X1iOgg4AhK/6mqxWu9PfmIqPGaDmT6pBRHYq0g8ttUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1uHd9Hlfp3X+sLbp9+7O7mR2uT00TMbOun6dYys6+PcQKn2Ap7OajSST7QrBKA+d
         yEjt8/If9aeCvAee6/5pGCltHcn1PukOpZM0s2gtSv/f18EiDSZHgIIxTyo+a+WIZ6
         qOpsaUYkCC+EyUT152+wqU4pG/HNCZqY93be+VDKCIOQ2FByKs3y0d7CaWxCfZRKGK
         vzFFDtP4+2Ht6utEKwnF0RiCwgAsjLX8f+OztJiupQLu+RYcHpIc5bEYVyVCfC6bBC
         GEPvMzwde+igHfvvscxlTgTqRS0ywAMmTt2G/XKGiG6yghJlI5wjeSFcGIM52cRJx4
         k0usUUa7YPDUQ==
Date:   Sat, 5 Aug 2023 11:19:47 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
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
Subject: Re: [PATCH v14 25/25] MAINTAINERS: Add Gunyah hypervisor drivers
 section
Message-ID: <vw6f53dpu73pva3g7s6v6egv3u25ujqpetljlcgaom7x4hl5ty@nsascwqaogea>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-26-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-26-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:53AM -0700, Elliot Berman wrote:
> Add myself and Prakruthi as maintainers of Gunyah hypervisor drivers.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
