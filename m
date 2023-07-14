Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D07753523
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjGNIim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjGNIif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:38:35 -0400
X-Greylist: delayed 1803 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 01:38:34 PDT
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DFA1BFA;
        Fri, 14 Jul 2023 01:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689321188; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=TM8MZxQB/7jo+xJQb3zgTJFryD2sPGFPeQvF7ukcdm9baBe/TjGdQS/HdmrsBtWowi9r3nbDspzcMfeV4m2jz7k5UL7yLPNJxeYPWZ5UZHs9LPDskamrTFWPy9MtdjCGDA6wTUqUwpxMMVbYIjgE7O42MzfbXUGYGfqtlUsdmjE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1689321188; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=dfU3bmEcLO9wC6Xg4O+oSSw/vZF8eYX1f24otSK7uUc=; 
        b=Wjce7nJoiuWPCodMrGOxHIcaitrevJkcqWtLxYHPBeJCxSECcZcGFv1rlonrcyBQtIpdnxUBR8gnnMi3GBsbhfKZn2haf3ma4+FHkYox39aexz9TnpiWpZrbJBxi6nCV6DCqu/2uy/BwwbpGwS/7rSi1sHDx0ziMOpYPPctvJ9Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1689321188;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=dfU3bmEcLO9wC6Xg4O+oSSw/vZF8eYX1f24otSK7uUc=;
        b=pkIKA6WCGPvH/nHn571QXnWU148KOTuGapMk149dd0qKofVE+zfGJGlcqmjF7Mki
        F9QU4WISF0rCyB95Wf+vOoz3Hh9JuDVESnBQdBr60oAMgdGzTsJVnSGsGJtfXGt+QIZ
        Zoo1dbTjkNoRa7v8mq1XHjUwwkdICmAAnsxzthCU=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1689321185397745.431298831732; Fri, 14 Jul 2023 00:53:05 -0700 (PDT)
Date:   Fri, 14 Jul 2023 15:53:05 +0800
From:   Li Chen <me@linux.beauty>
To:     "Rob Herring" <robh+dt@kernel.org>
Cc:     "Frank Rowand" <frowand.list@gmail.com>,
        "devicetree" <devicetree@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1895363a02c.112ba0843416665.413138938060634927@linux.beauty>
In-Reply-To: <CAL_JsqKSnhvgDfXA46v_CzFn1q1U_Lr7N=JA8bMYMrPAgENOWA@mail.gmail.com>
References: <1894ed7a1a9.f5e49d5d141371.2744760538860302017@linux.beauty> <1894edd07ee.b7245352142935.3234373322799059936@linux.beauty> <CAL_JsqKSnhvgDfXA46v_CzFn1q1U_Lr7N=JA8bMYMrPAgENOWA@mail.gmail.com>
Subject: Re: [PATCH V2] of: property: fw_devlink: fixup return value check
 of strcmp_suffix in parse_gpios
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
 ---- On Fri, 14 Jul 2023 00:45:24 +0800  Rob Herring  wrote ---=20
 > On Thu, Jul 13, 2023 at 4:47=E2=80=AFAM Li Chen me@linux.beauty> wrote:
 > >
 > > This commit addresses an issue where enabling fw_devlink=3Don was caus=
ing
 > > a PCIe malfunction, resulting in endpoints missing.
 > > After thorough investigation, it was determined that the root cause wa=
s
 > > an incorrect usage of strcmp_suffix in parse_gpios.
 > >
 > > Fixes: d473d32c2fba ("of: property: fw_devlink: do not link ".*,nr-gpi=
os"")
 > > Signed-off-by: Li Chen lchen@ambarella.com>
 > > Cc: stable@vger.kernel.org
 > > ---
 > > changes:
 > > v1->v2: add Cc stable
 > >
 > >  drivers/of/property.c | 2 +-
 > >  1 file changed, 1 insertion(+), 1 deletion(-)
 > >
 > > diff --git a/drivers/of/property.c b/drivers/of/property.c
 > > index ddc75cd50825..261eb8f3be08 100644
 > > --- a/drivers/of/property.c
 > > +++ b/drivers/of/property.c
 > > @@ -1272,7 +1272,7 @@ DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 > >  static struct device_node *parse_gpios(struct device_node *np,
 > >                                        const char *prop_name, int inde=
x)
 > >  {
 > > -       if (!strcmp_suffix(prop_name, ",nr-gpios"))
 > > +       if (strcmp_suffix(prop_name, ",nr-gpios"))
 >=20
 > strcmp returns 0 when there is a match. When we match ",nr-gpios", we
 > want to bail out. The existing code was correct. Your patch just
 > disables fw_devlink for all GPIO dependencies.
=20
Yes, your are correct, thanks!

Regards,
Li
