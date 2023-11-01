Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F467DE359
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjKAP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjKAP3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:29:54 -0400
Received: from mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417D1DA;
        Wed,  1 Nov 2023 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1698852560; bh=8JZ/Xm93s6Pe/glm6UMFP8lzYw6hWMYZSLM5kQwh7A8=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=aFrqabgRUnYmfPLcc4RAo+sceWLlJhSTS7CUsuMz0ZNaAHMb1+lBfYda/F2ZVIZxt
         /C+0/lgZh01wsVkqEC3oE2BRyi6NRxckkCxo6U3uInUb0dmojc+c4LEi1X0ya5Yi79
         sVcW5uyxlgYPeRliyeKwVikhGgeV5FvcIbifUiZo=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
        via ip-22.mailoo.org [213.182.54.22]
        Wed,  1 Nov 2023 16:29:20 +0100 (CET)
X-EA-Auth: t+PrxXcdHtU8aMBIbHkhq1Jt0EX3B48jBFIYIdTMsBYBoMkLXopLisyWlBB7SBon7hEA1q+bEsEF03sZMfqvsOR2yvukLgFsLo4I9+AtKYg=
Message-ID: <0f294695fdfed60c385deadc9d030c225816b4f9.camel@mailoo.org>
Subject: Re: [PATCH 2/3] media: dt-bindings: ak7375: Add ak7345 support
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Nov 2023 16:29:20 +0100
In-Reply-To: <20231101-wise-childless-ed44729657c6@spud>
References: <20231101102257.1232179-1-vincent.knecht@mailoo.org>
         <20231101102257.1232179-2-vincent.knecht@mailoo.org>
         <20231101-wise-childless-ed44729657c6@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 01 novembre 2023 =C3=A0 15:10 +0000, Conor Dooley a =C3=A9crit=
=C2=A0:
> On Wed, Nov 01, 2023 at 11:22:56AM +0100, Vincent Knecht wrote:
> > Document AK7345 bindings.
>=20
> The commit message should mention why this device is incompatible with
> the 7375. Something like
>=20
> "Document the ak7345 voice coil motor actuator. Similar to the ak7375,
> this model has 4 unilateral phase detractors instead of 8."
>=20
> Otherwise,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Cheers,
> Conor.

Thank you for the review!

I don't know anything about phase detractors, nor any other details
(having found no datasheets for either of these ICs)
apart what could be infered from vendor/downstream drivers
like in the commit text for patch 3/3...

So I guess I'll send a v2 with a commit text along these lines :
Document AK7345 bindings.
Compared to AK7375, it has only 9 bits position values (instead of 12),
20 ms power-up delay (instead of 10), and no known standby register setting=
.



