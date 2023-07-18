Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC9F75733C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGRFer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGRFeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:34:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AB2E43;
        Mon, 17 Jul 2023 22:34:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3162612ED;
        Tue, 18 Jul 2023 05:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6862C433C7;
        Tue, 18 Jul 2023 05:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689658481;
        bh=M8JLZ0QR47SqxJa/J4XXXk1uEeaKLT3sFbyi7Z1T74w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AinEzFzjRMVE+ENvkGF+GrrjhXHGEbmt678SVpAy6cA017j0tDgMdEACItxBeT5HT
         v8ntwYYBMpTpvJuaQk/XoC1x5zPEZFj+hxtSeXuJRmztHCkASVBl4dzXf2mp30dTzq
         /Ufuu7NnwpayS/2yjnz6pjxROBuvVAOmZa2SVVCw=
Date:   Tue, 18 Jul 2023 07:34:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V25 0/3] misc: Add driver support for Data Capture and
 Compare unit(DCC)
Message-ID: <2023071848-blend-acquire-d7d0@gregkh>
References: <cover.1687945879.git.quic_schowdhu@quicinc.com>
 <c91e1aad-b81f-8afd-6ee1-c83ed4844b04@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91e1aad-b81f-8afd-6ee1-c83ed4844b04@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:33:09AM +0530, Souradeep Chowdhury wrote:
> On 6/28/2023 3:53 PM, Souradeep Chowdhury wrote:
> > Souradeep Chowdhury (3):
> >    dt-bindings: misc: qcom,dcc: Add the dtschema
> >    misc: dcc: Add driver support for Data Capture and Compare unit(DCC)
> >    MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver
> >      support
> > 
> >   Documentation/ABI/testing/debugfs-driver-dcc  |   10 +-
> >   .../devicetree/bindings/misc/qcom,dcc.yaml    |   44 +
> >   MAINTAINERS                                   |    8 +
> >   drivers/misc/Kconfig                          |    8 +
> >   drivers/misc/Makefile                         |    1 +
> >   drivers/misc/qcom-dcc.c                       | 1312 +++++++++++++++++
> >   6 files changed, 1378 insertions(+), 5 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/misc/qcom,dcc.yaml
> >   create mode 100644 drivers/misc/qcom-dcc.c
> > 
> 
> Gentle ping

$ mdfrm -c mail/todo/
1480 messages in todo/

Please relax, and help out by reviewing other patches on the mailing
lists in order to relieve the burden of maintainers and move your
patches higher up the list.

thanks,

greg k-h
