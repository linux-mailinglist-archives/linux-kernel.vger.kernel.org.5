Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A6A76D851
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjHBUCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjHBUCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:02:14 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2119.outbound.protection.outlook.com [40.107.10.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E1E1FFA;
        Wed,  2 Aug 2023 13:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4qMeMlcEm6b6eF006egq1s6Q8dMN3/y3QTH50AWrHyKNy6zJnD5BCCO7gmanVd1TCAtHyA5s3lDqcRm530evx28viWVbedF2gz0kTlGDa2M9nIvSn2jGEb0vzOEHs5WoEr35UXm4l+zshEXQgFAs+vuhQZVaQnDx421/rlHvM6Jg3/jAyOfgP8a/yRy8rC8oxg4qS8GB1IbqF0j8RHxyQHmrggD8Mh0M3gqzFr+6Ckwe1xYB38agePPkkn/Rt9HExD6haaE1/ce0//9zoafVKckbZWUatjsJibb4oRvXcWoOrr6JsAQ/oy32r0naZW//HRDB8nV8mM6bf3YfsstbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQXjmHeoM24c8436hoJ6sU+SRBOz6IQqL9PRKIljh20=;
 b=cpyftby4j3WgEtWuqnn1lOHBmkzONfhY1afM6XuhKD3gMMnQ5+2fO2Ie8D5NDWWBCk5+OYRSKZz+qCJOXbXLZ7oeYPXJ7ypzPnt0y3xFWnxSWsLt4c0pYmtd3+sNg+rQvi8a7ntjX5HINkrA8eMBMWkXbqSfyl76W71I1xxbi9kWjttjeuCnPmgOpr1KboNWpskVFwWMI0dtoR4OGNVW4WY8fHkKQe65hv80xDpsF0fKnPiq13bqzzrmQqLDkFfCRYBZQeSzcuKXLbRpDoc5WxbVCUyAfSR7a6rS/wGhnEnlEiswekSmzUjf45yIUFAzGBh5RLhPcmci6u1Na2k3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQXjmHeoM24c8436hoJ6sU+SRBOz6IQqL9PRKIljh20=;
 b=r7VJFJNMpA0Bp+Eelf9gwyQgGSOMqrvSDWay/Ug99sliREhIIslYuBWMiDPhGZQIjjDqxkEEGm7jb7gALH22j9ANpXovo2nL12afIs8q/IaWb9IyivVw2xYbHiYwwC8VQIeIqmCzKzjSEUelqSce3Zs06KuOAVPS1+27sjX2st4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5491.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:159::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 20:02:10 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 20:02:10 +0000
Date:   Wed, 2 Aug 2023 21:02:08 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     changxian.cqs@antgroup.com, alex.gaynor@gmail.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        sergio.collado@gmail.com, tate.thl@antgroup.com, wedsonaf@gmail.com
Subject: Re: [PATCH 1/1] rust: macros: fix redefine const_name in `vtable`
Message-ID: <20230802210208.4dce7501.gary@garyguo.net>
In-Reply-To: <20230802195020.3062950-1-aliceryhl@google.com>
References: <20230626074242.3945398-2-changxian.cqs@antgroup.com>
        <20230802195020.3062950-1-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5491:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ed6a6d-7c51-4510-74db-08db93935b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTrIke4tsG3kyOlwaNAlOUIYPWzG3HhC7GDhoTGxXQgeRnYu3NGRcWhB4KwX3bwQ/qR9ELPONIKumLnrJDToyJrtkbk4FQFR1iKHUlkmZZX9QvkadguCAtBLlozAtnISwCgnegIsw0kO0ohz/Et3zra9nvw498UvowRA3F+hUktywrW0eB1puQ09UdlpvVpd6TshAhZxNp9hSNXaIPPim2Gy0RL5kp/MJniByKI6Uea0otNreaY4fRclyLALvU9JRvMZjPNVgUnUCqnTmCs+nj8x4sfM+sW7ydU/RiPOtrY5vnixoYXZAD3rs++cF6fxy+ys2uCfFQXXTYghOwyMgq1HVGmeBmU40sRz+gMu6x3CyvYUGgeI72N8c3mY2pgLULd6HX7ybxi058x0G7S2oVjFhjyBAaimMVtAvU+tSej1yliWv3Hp0hXwY/KxOdg512t2SplE52OQpn0HfUfcKlU22Bcj/Mkl4J4BYKEa1326pkPdoWCWroKrbEEFXG2gD+xX8iTjb6HC9Weoq9zf7HescgzjI500qJIgghuDSYJQ9E0jbddbSShe4MyBWcE1uB3Fv8aN3cCgkgqPnPzCVgCH0os3fO9F8yxhdVEEmMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39830400003)(136003)(346002)(396003)(451199021)(36756003)(86362001)(478600001)(38100700002)(2616005)(1076003)(186003)(26005)(83380400001)(6506007)(41300700001)(8676002)(8936002)(7416002)(6512007)(6486002)(316002)(4744005)(6916009)(66476007)(66556008)(5660300002)(4326008)(66946007)(2906002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L5gTo5+XTDtKEjhflmtbBCLM6ReXhjYn4YfGQGCFf7v0QseTXpJKpLOKcuD5?=
 =?us-ascii?Q?jR3vyKXdQYZCicCmi6vMT19T/Uz4Rj1pUhqqRN9kSZ8l0rE0libCn2iY4Imr?=
 =?us-ascii?Q?9orGjXbdfcFTgFKllmMogChKkFS9/dwtYURAP9bkDAb2lr4ZZpntRclRkVJr?=
 =?us-ascii?Q?iOWPje6wd8Jqz8++mEY0JC6/cvif1Uh2PH8m9uX3SCnQyt8ycQpwAGRNCEJ4?=
 =?us-ascii?Q?1sD7MdaUx1kWFZM1dSxWmYZF5dSkKbgIFo+2AGOFJu4/Cywc6wGnYWCwaZZC?=
 =?us-ascii?Q?IqUlf37WdSG5YtTlQ/dJT45ZGwK2CvPIf2pMFJAU+HvzTWIxZ9F+NTd1MGDW?=
 =?us-ascii?Q?i1uaoZq46NlthOQtc1HkQxdfu+ng8JT3T+TdqcGnxK90Es+KbvSGk59+xVDD?=
 =?us-ascii?Q?VzBB+trAla5wJ68TYUG+DtHXOIWqquDXSU9YEI3Y0G2vhhVeksCiWZNmNV/S?=
 =?us-ascii?Q?C4DK3Q/e80idfsOYkpVD2qH0GbWL/9pW8vVgcAsI2vb7kqR1tiSHXYA6H18U?=
 =?us-ascii?Q?7/kWD23NmjFzdgkTwE6eF6IqdIEEG5TjKFtsgm+3OUtmEIxFoCiFT+7CIj50?=
 =?us-ascii?Q?RnStiSeYI4X0li7J4kHvewks/EStApEFdu83myD7+GkohNvOPiY8En/jw1cT?=
 =?us-ascii?Q?7TLlaJaE5nNZIeC8arGpqE8qEW4XEeDzXrUl3OVzFhT9X4GmmOdkVrfIc1dY?=
 =?us-ascii?Q?XGYapU+43jlrm4B3vR9mOV+0KZgxgSgvIGhDiuturEOCrDrd/qeWiX8jCfJ0?=
 =?us-ascii?Q?Uh1kgTueNrhwTzcT2YP+g3NrdDIvjA+MgQ1VEo1gtcttV2LIyeciMksYP57k?=
 =?us-ascii?Q?DRcr2d2T0le9Vwk2qZRIOVz4LbjjsYvKug0W3D/s1DpxdTstwSPo5w7PEmxq?=
 =?us-ascii?Q?axOAtE6KqXdnowFMixZ4ABZiGDL1P79mtfJipmO5EIU+MZOa8T+XnC3KaSUJ?=
 =?us-ascii?Q?Ve7X1CygjKGsE1Dmv/aME7Tpapt76oIaIfRPAPAQFSu+aXjsAjRSsI5rh8B7?=
 =?us-ascii?Q?SSoFEt+j0RDc3z7cYEaK74uZlByAFXSjN06CmKi83ccYIwylfB7nYAeAyn7D?=
 =?us-ascii?Q?j8QAnMM0CpEJtvd8WDO199zVIhp9D8mpF+7KgQvG3DfdF6efoZRsXsmw9nsT?=
 =?us-ascii?Q?57qm2O0EO4Qildnzh+E9yzaCSQD8Xu49XKiCm4Scea20/WnVQ0mdx9u4LeQS?=
 =?us-ascii?Q?pVi/ywOCaNQpW850TFkP6h7MXOadd/6wwMSgI0AtMz9fTtEfdoqXABGJPonL?=
 =?us-ascii?Q?aBVS5QnOp2sRQK4DJb1yJIIXR9ndCXLRpRS9Vr4/b5CFBpDnrtocqf+MwWb2?=
 =?us-ascii?Q?/QgN70hxdtp5LCDcOpsYqD0o4zsB9Qyrj9syzi56ZYEzdxPfMuuLY/7CGkUk?=
 =?us-ascii?Q?12Ei4JQIAYwV0EA/vWWWGEN/oHOzibB3j2tKjhu8TxELd7e8pPaZgHaz+6RK?=
 =?us-ascii?Q?fFoHHsnfx8D79AZhs8nB+XpHlwgkixmlGqzT/ZVrg4sY94FcNAjjQmh6ohGO?=
 =?us-ascii?Q?dsNPD7keGJN9XUXuz6PIiGxcrwdJc4ZSswjoEOs/foPMS16LNgv46T1eBL2C?=
 =?us-ascii?Q?uq55ELHui9nImXYKMoA5HCAEj8ldfYXtjY4Imfhn?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ed6a6d-7c51-4510-74db-08db93935b1b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 20:02:10.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vO023dEgJfqNTnRgXxP+ucxSxlCqd6Dv4dpCjcawHO/s1/fBuS8Ero7GJbRGHS+rO0WkFEzOROjj7eTKiUHH3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Aug 2023 19:50:20 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Qingsong Chen <changxian.cqs@antgroup.com> writes:
> >      let mut body_it = body.stream().into_iter();
> > -    let mut functions = Vec::new();
> > +    let mut functions = HashSet::new();
> 
> Please use a `BTreeSet` instead of a `HashSet`. A `HashSet` has
> non-deterministic iteration order, so this will make the macro output
> different things each time you run it.
> 
> Alice
> 

Good point.

Another way is to just use the existing `consts` HashSet to avoid
duplication. Something like

	consts.insert(gen_const_name);

after emitting the const item would probably be sufficient.

Best,
Gary
