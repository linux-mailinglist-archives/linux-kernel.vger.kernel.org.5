Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA807D2551
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjJVS20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVS2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:28:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F2E0;
        Sun, 22 Oct 2023 11:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRus//SPzae2jdyzzf0rmwB1CNu7We8cfCd8XSo5bxnz2inewqxs9Rroh8OlQ5ThmFVmhuGi+Y33jNOJu03cFtfTOnFyx11yeDLE6SkLRtqXVU02wzJjWB6sZKLVuAPcVjfpLvIcr9C/4SjI/xDZEPwX0dn0DIOxKB60v4xnm5bAYinXZQqfJRKEuksR19UeKlJfkrooozFmUGgKoiZsYqTLp6CnsrXnPK6Xub6ae7bXAej5SaOcYrtn9u5V0V4wbHnB2qjuGUle1KG1lDc7IULEEegRaL1rydfIHvN4YJmqrBFEEspvfPzPaTywSJDQ3su4apzUuFRIaI/OtuftdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bguMoSyeuFLmZ7hAyCAVY0JsaNTASlkxnBZas76M24o=;
 b=h9zJBMpTJbppwuOohZw2ibQNP4LKZEDIV3G1ueLmtg30YlM4XMr40a7O4/4qi+WrAon3j21sjmaQE12oW0v0fZS1cATPdqgYUT6bZTwNYN5SgpEPqvN5Vb4EDJXVQDzP3wjYrFI650beebeyXwjeBAF03KmTaofuRCYOVQD9lNSKfgeB/5ygcBEXi/mRdAdh0GmFIPSwSg+Dr3MwHFzzoKZhSjlaZlUk7s+Mcg11oqkaLUZp/5CoAbVuDvLUt4sK7y4piYzu6Zp7eUDLvB4tPBRkujWXWOQ7namhcfepDXispba6iVz4aM7zjFtT9qNfRQSK29ecKgJRDH9tob8z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bguMoSyeuFLmZ7hAyCAVY0JsaNTASlkxnBZas76M24o=;
 b=GnZ4U9Tg+2lD0k/rFtCF2QJkzvs8wm++OPCqbciUap0lmtssGrUr0KFgj9wrfsSLp9qxJTaqLMyhbQlEhLaTJcgOTAwjB2AMQcflXO5j8qockNmh9gMdj29iU6MKeELrUOkG9EX/5zt1CtQJHamJkvuD5TCsfmJeCV3m9EVsptY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com (2603:10b6:4:7c::37)
 by SJ0PR08MB7831.namprd08.prod.outlook.com (2603:10b6:a03:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Sun, 22 Oct
 2023 18:28:16 +0000
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::7eda:274f:8165:2155]) by DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::7eda:274f:8165:2155%4]) with mapi id 15.20.6907.032; Sun, 22 Oct 2023
 18:28:16 +0000
Date:   Sun, 22 Oct 2023 13:28:14 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
Subject: Re: [PATCH 2/2] Input: add Himax HX852x(ES) touchscreen driver
Message-ID: <ZTVpvlkORe4E41vy@nixie71>
References: <20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net>
 <20230913-hx852x-v1-2-9c1ebff536eb@gerhold.net>
 <ZQYUe46/rj8jqNvg@nixie71>
 <ZRg-uZskk07jxup0@gerhold.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRg-uZskk07jxup0@gerhold.net>
X-ClientProxiedBy: DM6PR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:5:177::15) To DM5PR0801MB3767.namprd08.prod.outlook.com
 (2603:10b6:4:7c::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0801MB3767:EE_|SJ0PR08MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad96ee7-ebef-49d4-6eb3-08dbd32ca8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRdZIJLKQJ6eUXAbfvuMl4qkx/Nnj9/MOKM54SZmWkJ/UXpiUtIVlgy9i6k+N5VU1ajl5AstIMV+v03gjp6OzhsKq8c+HfALa4vZOojsq/Z9dBKrkiB1ItW4/ZEF71hvGcco+rIELgyQr3Q6tDYK+8nhjAZ7J/CTWVzkilnYzmvOXmKcrW5fFVJd6xnJFt/iUCs9IzFqIH8Bxa/zHInmxiH5Dxbnqz1PUsd3k5P+n8SuOWZNnCAULYjT6D/yZhTtG76WLofOJ7e1jQNLPGvOw7+Xz2gRDy7L5x9Urivr+ZNrnTTmgs9xDk/EFp11GNwpV85hRs9kf2nBUBKhTHBxovjP4evDNHBQu7xC7kdO8X337HO1c+HVNTN4Xia3wiMcGY/tyMiiiVKZS//0BELjbTBFOUzOeJ4BTLBt5KwXbmGdN9YlSVrst57stweOMPY3cJVb+1Q2+aCBAiKUz1IqJAoViMOWPfJwNT3z0nsCYWJUPspKkunMfOyVUDaq14kcMNN/N8ubA+5DB4MfIrfbum/M48gKUa7s65L6lY07FjrsbSPnxymqpLV67W3iuAke
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0801MB3767.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(39830400003)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(33716001)(38100700002)(2906002)(41300700001)(86362001)(7416002)(5660300002)(8676002)(8936002)(4326008)(478600001)(6506007)(66476007)(54906003)(316002)(66556008)(66946007)(6916009)(83380400001)(6486002)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gRee0F/tdLeF68xU0B6B5vcQEr40jTr9vhu+wdPmBntVPKHDQaITWpMK2rm7?=
 =?us-ascii?Q?N+PdUILWk17/ETjcjYoDtnTOWKNlzt/6E/8hkAn4bQgfE5c1p+AIWSliD+6Z?=
 =?us-ascii?Q?nARQY8Suy7tdKO2NtnkltpKltfKqCJSIkOJNfKeWjpSYxxQ4PPEdLuLTVE5G?=
 =?us-ascii?Q?4BqSMWLDfVwn/eRbFVfWAflFXrY8gNXe3YfN6XkjIaOLW4kWJTnhs9+juhtf?=
 =?us-ascii?Q?EEsuEZfuwucAHXuSbNcHN0Hyebr9VqCR+jL56XDRx5l9EVVwrMu8LGT1z5Ne?=
 =?us-ascii?Q?kVTiBjiqvzcC1M5H31FhZn1GETJt+t2mlC/Nx6T7qF2gLR7i9SLK6GVD33VE?=
 =?us-ascii?Q?pnHWEOunCfJJkbbWLmak+EcrUfS9kOp1E7SGrpGGv9b1mHw30iy/b6NYBxSA?=
 =?us-ascii?Q?ijXXY0lt3pFVNe6QblfqHX3jrVkXZAofH4tTKfl3dqbf9iy9cPJM05hSrWhz?=
 =?us-ascii?Q?aVjRCzaVnvjoMk/DryRrBDunOZFFJOiweZskDPkqdHCJvTbc3Ne9nl/q1jIw?=
 =?us-ascii?Q?XSKrJXCjSN7u5VkU49SAvVdB7MkG6qD8BIvC204Z+I5yrDk4mFleaFtTUe3D?=
 =?us-ascii?Q?MVc6yhvN152YrS3tNg97mhV2k5fudwEh1RtFRTkwGahbSltLfRh1rrXwD2Nw?=
 =?us-ascii?Q?C4sFh1mLqDQlo+NOFr8Uz7UV1Ju2YDxsXX3PuGoOjcVbv3ynkO/cJ4c/ncn8?=
 =?us-ascii?Q?WiWFd5AxlictbVq5Un4A7xB7TgtO39w4P30CcbV3Rasatusa9cyRXcy+PD6C?=
 =?us-ascii?Q?da1kPokIxiAVpxUzrkyzk/nc/dob38Vmcca9DBaEWsvmhP/zcL7PzEN1dBS0?=
 =?us-ascii?Q?Jjh6g8ynEmM1IXPwQFLE13dXwpgwPjW2K0OdNUiixJ9wVA0HH/AmYdquHUYM?=
 =?us-ascii?Q?OKELAschCHkLexikrShoA/BJ5Z/FJMzmAsk9PWPVb6FHXJEwYuFfm9nwl2dl?=
 =?us-ascii?Q?CAw3cVbewPprpWtncbJDhiJtkWqcYmUxR/a62BRNf9qjjfNElHGnV1on2lcp?=
 =?us-ascii?Q?N5Ao0XZXlSXnp//GSKy3vyDQavdKoyOzMUyrJ6MVPnaQkasI4VKR8YF9YY96?=
 =?us-ascii?Q?YFpiPe/nd+fwR7GIlok3yq1nMkHs4zL0nlK+OkXm9WkDKmw0I7bsMQCogEFF?=
 =?us-ascii?Q?9DEgHOj5rY4bMLj4WzHpVFguicbK7B2MtLV8241jNLPx37i2mDnbQ4gCfMjy?=
 =?us-ascii?Q?5dZ4NTZy58+bAQrgYUSR+/49vVnPQXPKq++UNqdIqvY0YlOvK24cTO9n9Vjr?=
 =?us-ascii?Q?N8NidyiYzoJjUa7Njh+ahCxsRR93LL8IJFXNytlxxuLnr/7Dwr91P5Z/mJ03?=
 =?us-ascii?Q?TCFiw7aVPT2A80+9SMIJgq55al+i7GB890htNmZph1LTzdLcS/XLZU5RABIQ?=
 =?us-ascii?Q?DxdUx0NRy9i0EFewsq1eWDUhy5jydMBW0KINa2Ul5yWe6xbRby46CEbMX5Jz?=
 =?us-ascii?Q?U3nfSXOJXrxWnrqaai+q3cpTHU1GASOBPi/fu3woBGbTYarlhy2lQI9fX9Fp?=
 =?us-ascii?Q?g2K4swDeRx9fXrG1oylK58L524bzxI8G6zXTzUEUiJpAQhUrjLVBXfhbi2pS?=
 =?us-ascii?Q?XijyVODJ8DJuBuO9heGvb8m9YnEObU3ijIAq8tBv?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad96ee7-ebef-49d4-6eb3-08dbd32ca8c4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0801MB3767.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 18:28:16.7659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uULBDG4KONP44Lza3E23F1TCurD24iUUCmuI/6NFXukgKY1OeUiIGlmPwVb6Xu+faFnDrPAeS7qhwhT/b5mNMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB7831
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On Sat, Sep 30, 2023 at 05:28:57PM +0200, Stephan Gerhold wrote:

[...]

> In v2 I have added linux/of.h and linux/mod_devicetable.h, since I'm
> actually using definitions from these two only. Seems like including
> of_device.h is discouraged nowadays, see commit dbce1a7d5dce ("Input:
> Explicitly include correct DT includes").

Apologies for the delayed response and some confusion from my side. What
you have added in v2 is correct, and what I should have suggested in the
first place.

[...]

> > Nit: it would still be nice to preserve as many return values as possible, perhaps
> > as follows:
> > 
> > +exit_test_mode:
> > 	error = i2c_smbus_write_byte_data(...) ? : error;
> > 
> > > +power_off:
> > > +	hx852x_power_off(hx);
> > > +	return error;
> > 
> > Similarly, with hx852x_power_off() being promoted to int as suggested above,
> > this could be:
> > 
> > 	return hx852x_power_off(...) ? : error;
> > 
> > There are other idiomatic ways to do the same thing based on your preference.
> > Another (perhaps more clear) option would be to move some of these test mode
> > functions into a helper, which would also avoid some goto statements.
> > 
> 
> I played with this for a bit. A problem of the "? : error" approach is
> that it hides the original error in case the new calls error again.

That's correct; good catch.

> 
> Let's assume
> 
> 	error = hx852x_start(hx);
> 	if (error)
> 		goto power_off;
> 
> fails with error = -ENXIO. We jump to power_off:
> 
> power_off:
> 	return hx852x_power_off(hx) ? : error;
> 
> Let's say for whatever reason hx852x_power_off() fails too but returns
> -EINVAL. Then the final return value will be -EINVAL, while with the
> current approach in this patch it would return the original cause
> (-ENXIO). I think that's more clear.
> 
> I also played with moving code to a separate function to avoid the
> gotos, but I feel like that makes the fairly focused logic of this
> function (reading the configuration by temporarily entering the test
> mode) just more confusing.
> 
> To still fix the error handling I ended up with duplicating the
> "success" code path and the "error" code path (it's just two function
> calls), i.e.:
> 
> 	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);
> 	if (error)
> 		goto err_power_off;
> 
> 	return hx852x_power_off(hx);
> 
> err_test_mode:
> 	i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);
> err_power_off:
> 	hx852x_power_off(hx);
> 	return error;
> 
> I hope that's fine too. A bit ugly maybe but in this case I would prefer
> having the main code path (reading the configuration) clearly readable.
> 
> Let me know if you have a better suggestion for these (I'll send v2 in a
> bit so that you can see the full diff there).

Maybe we can massage this just a bit more; I have followed up with another
suggestion in v2.

> 
> Thanks!
> Stephan

Kind regards,
Jeff LaBundy
