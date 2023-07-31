Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DDA7689FE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGaC2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGaC2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:28:18 -0400
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Jul 2023 19:28:17 PDT
Received: from out-91.mta0.migadu.com (out-91.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F69E50
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:28:16 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bcheng.me; s=key1;
        t=1690770178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=vPdtbQm8V9rffwx3H/n5X0xB5XkYDYWRBPxYwhIjFQg=;
        b=Ga2lLIX8txBBTAhb6Vh9WsLKy8gRdcayGbTIR1oOmEkMjeg9cN0aiR9rYHBzMeBkH0WQBQ
        thUlBvoInIT3yF5fHdiKvBSF/119c5VscmewD77XgXOQto9ou7VAsPx+Q+Cc8l03a0ivc+
        z9kywYIjqmSjfwPBcL+l4R3+EV7hTsb9LAcEC9ofq04MSSGIj6OeCCvf7J7aA3CrcGbiST
        /X2WZ5M/0t4HBjqH4e0WU/o9POJWTpBDqJpjIgYrwrA2QjjFiGVXCoQnCnE80L3te0zsDh
        tfXhITxicxpahrtVYqMrp8OiEHqgCpqhxBephjSPZfE7/pn1ShoXWMkBq49CvA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 30 Jul 2023 22:22:55 -0400
Subject: Re: [PATCH v2] ACPI: resource: Add a quirk for Lenovo Yoga 7 14ARB7
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Benjamin Cheng" <ben@bcheng.me>
To:     <mario.limonciello@amd.com>
Cc:     <git@augustwikerfors.se>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <regressions@lists.linux.dev>
Message-Id: <CUFZQ0PV3664.3HDBJ1V15F1E8@gold>
In-Reply-To: <20230728191408.18141-1-mario.limonciello@amd.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be possible to include a similar quirk for the Lenovo ThinkBook
13s G4 ARB?

a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
doesn't break the keyboard on this model, but makes it very sluggish and
unresponsive.

Adding the following entry fixes the issue for me:
static const struct dmi_system_id lenovo_laptop[] =3D {
	{
		.ident =3D "Lenovo Yoga 7 14ARB7",
		.matches =3D {
			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
		},
	},
			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
		},
	},
+	{
+		.ident =3D "Lenovo ThinkBook 13s G4 ARB",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21AS"),
+		},
+	},
	{ }
};
