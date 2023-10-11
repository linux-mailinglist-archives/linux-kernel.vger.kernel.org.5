Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A697C555B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjJKN0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjJKN0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:26:16 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EF098
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dA6iqc7NwacsVn2nL/GeV/zrTBiJpTxcisfIb9/f3gE=; b=gyaE1x/h74kkBuGzOxmzcVo6NY
        Hw9Q+7bIlke/zCrR9Va8tnvzGmZ758PArH/saNPOM49nt42VYoca1gTkUNbmN2vEjwVmNRkVVDp3q
        bl4FU5LWyb4WVlsSm5WHDmCBTCXL3bPfqw7WeVOl9CJZC+bmiquNvxnwKc1siRsib+mu1cxJUmgcy
        cajqaMAqV1PONan3xeSXJVGMj+/jPYg1ko9wMkQSunn6ZM+uGThK6xebAZfqOHEueqzSiAOlVlwyT
        BrkNXu2EpkRG54aU4WzzcfiKjjH+LOkSXguSkJjMueuZr0jsMZX1UTNm4/Nqa1GuZXCr1j8CWfDqh
        Y0VfYukQ==;
Received: from [192.168.1.4] (port=11306 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qqZDy-000326-1l;
        Wed, 11 Oct 2023 15:26:06 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 11 Oct 2023 15:26:06 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <conor@kernel.org>
CC:     <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
        <ante.knezic@helmholz.de>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <edumazet@google.com>, <f.fainelli@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <marex@denx.de>,
        <netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <woojung.huh@microchip.com>
Subject: [PATCH net-next 2/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
Date:   Wed, 11 Oct 2023 15:26:00 +0200
Message-ID: <20231011132600.26297-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231010-unwired-trench-c7a467118879@spud>
References: <20231010-unwired-trench-c7a467118879@spud>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 16:25:55 +0100, Conor Dooley wrote:
> On Tue, Oct 10, 2023 at 03:18:54PM +0200, Ante Knezic wrote:
> > Add documentation for selecting reference rmii clock on KSZ88X3 devices
> > 
> > Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> > ---
> >  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > index e51be1ac0362..3df5d2e72dba 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > @@ -49,6 +49,12 @@ properties:
> >        Set if the output SYNCLKO clock should be disabled. Do not mix with
> >        microchip,synclko-125.
> >  
> > +  microchip,rmii-clk-internal:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Set if the RMII reference clock should be provided internally.
> 
> > Applies only
> > +      to KSZ88X3 devices.
> 
> This should be enforced by the schema, the example schema in the docs
> should show you how to do this.

I am guessing you are refering to limiting the property to ksz88x3 devices?
Something like:

if:
  properties:
    compatible:
      enum:
        - microchip,ksz8863
        - microchip,ksz8873
then:
  properties:
    microchip,rmii-clk-internal:
      $ref: /schemas/types.yaml#/definitions/flag
      description:
        Set if the RMII reference clock is provided internally. Otherwise
        reference clock should be provided externally.

Thanks,
Ante
