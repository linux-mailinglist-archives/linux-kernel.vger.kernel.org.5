Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09AF75C9A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjGUORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGUORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:17:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1A41BD;
        Fri, 21 Jul 2023 07:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CD17r5VLMtrdBxBKwvxkNhS80w+XVa6mDcaAwhYXGEekoVBv8i9mbNMG7KdmB74F4YhgrYpBX62ouh9QSGrivINsJIXlzgC1pYMfcmfiPEPwJGIn9JA+E97Nn1aEVmLwXxtkOhApb2Lf9auDJtnvZmzZrrAKkxeWBKY1MXy+R/TsIPk3g7IifVQZxvjxT3hDG5O9FSY+IAmY8tVvCXGBjzUDqxCGhN7GgJKLbIm2tdx9kzLAkzkidCIrsTaxAo8ESW3JYNM7uxrpF3f4FHi/bGVLN4uCPYlMN9SeS9ed6LqJy69nEFZzgyqTjaJZc1hFpt2lPUBlEumSl4yi+uvrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efFhZ8iRKwXGHXdhrv/+zXVYUqWVKFGI4Lv1HjxGqGQ=;
 b=bjhNo3M3yUeOFpxa5uNW0g6KKEK1XS9+7VGgqtcvpCJwx8C6PXAT84GSEQrFLZH4Lo3CRE7E5n94EWmShEVy4za+ln2DzBbPDq/GjCopTdcu0rWwhMlGwBbk5AaMyOptqO9Go+odTivH9Alb2p9EynPbWIL014dvd/NUaWXYF0YTSweIcIF7Oc1rVeL/KIkHMJQjbatyTgReNyo2Fzc5uRRguGpv0MgHONCVU7sZIJffafYBv6j5TO7fPmWWeVfbjt1mJ4I8P1bv2htpXFpEqPVn8JZXQyijaIbtUsnEY7dsYiUMI5eYruZuhF/CAO/RmMPobJmCXrC1dOvQnaEHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efFhZ8iRKwXGHXdhrv/+zXVYUqWVKFGI4Lv1HjxGqGQ=;
 b=FJtEyXkz7iN/hQclpDh09qwNSGy0VkmTC/J37iVFFRdNy7n1ebA1R2LfJVoaTNKoutq/CdZ7A7LDNGIJqfvTpbarAmZzYskURrzWMQeOtBHGtADSAXsPRu8sqDVieV6lJjg59+6FgWmITRO9ZDQwGht9Qxv+XVtklMrl3dj3DF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5422.namprd13.prod.outlook.com (2603:10b6:510:128::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Fri, 21 Jul
 2023 14:17:40 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 14:17:39 +0000
Date:   Fri, 21 Jul 2023 15:17:31 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] xfrm: add NULL check in xfrm_update_ae_params
Message-ID: <ZLqTe9XroSlOs+39@corigine.com>
References: <20230721014411.2407082-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721014411.2407082-1-linma@zju.edu.cn>
X-ClientProxiedBy: LO4P265CA0112.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: 9520a668-0ecf-4ffb-a7e3-08db89f53d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wu+4X269cKslAWLxdE07vRqJy9Te9JkJIUr6BLsF7/J5YusgJqVXOYSaOeN+WD+Lcr2rHnVqKl0o7w+6OQdcnei4gpvAomidcrdtkzZkgAd+RIR0Cspk1iQskp2k0RbNyuRiWNgG3lMYme9KWJjSmQiI6Wh3EevLNeYsdrrLTKhVWVXLgKRQv1XzSSOFrcTmVGU9bcDoymyiXWIi0m3eTa2ho54dQ/890Cuy6JgoF3ZbyUr3KeftMKypTzycnTQpbuREG4nofWShCIlJrVhr5oKXvGqEK/EEgA8k0t80MtXRQ3bkM9vt26ayW3MUyHEdcjx8uaXkQ+K/Pm7uioLafQX151KDh1QuZWnMpcouUnO1NKDl7F81V1Gm489aodRSEu44uyEP84HTR69Y1+xu2NeR71pYOmsCGVNPIFBqMX2Q1wCuEIWsjJoOFF4LrRaCFAD7PvWZC1OtDQMpcLS++xXhflls72WQCgahNh2Li2BlkREOr2YXrHMwg2jyDCrRMGlBoSHP7hTlpXa5YhOT1emMlnMeGeI6nAu6b6vrTs6kv+QAtNnSjid8xfzlOr04VzTmusfQ6atxV3xLUH/j8jJoLW+rK8W6QKovshYpl2n7Sf3pV5Cx5pT+SA5SNX//A2i5ycEmmJXymLyQSNBilfcIYK8GWgsa2TKJzoxbv9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39840400004)(376002)(451199021)(478600001)(6506007)(26005)(55236004)(6512007)(6486002)(6666004)(83380400001)(6916009)(8936002)(44832011)(8676002)(5660300002)(2616005)(4326008)(41300700001)(316002)(86362001)(4744005)(2906002)(186003)(66476007)(66556008)(36756003)(38100700002)(66946007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jDin5IZanMBGUoDCeDy07tCI4c95utZiH1yi4NVAENE6yfm6A6YSOSn2aJDS?=
 =?us-ascii?Q?EBDlCuM81JS/lUfMxJGe7CozKmQeIYD8s/d2RfEP68lS2u6/zMVovn7RJ+O0?=
 =?us-ascii?Q?QVCmWj4j9mnRlDI8nxxi8phpyDgyN8wxrr9CKiLjW1ICeMSL6ZJx3zIMMcZY?=
 =?us-ascii?Q?R6K/tJlvg8HGynraqOfFZzJijiaJqCcDfeKjiqVI0YmMty12YvaupX4rHjK7?=
 =?us-ascii?Q?fBv4sOcmx9Z/d87sfG3CEyZdqOXuU+w9PLJtRkLUHNSfOYRcNN9ZzLjDlDex?=
 =?us-ascii?Q?o8sboXNKy8pBAsKU6dBP3qbrLsEZxRGR/QfS8YrK3YtDxHYxNSRfAgx1fF/k?=
 =?us-ascii?Q?p8ES11FxZ74+BClA3VTWJzNyjdeHsKMBKBhue730UkroFwDYks/oYhfOFTBr?=
 =?us-ascii?Q?X9mNGlcwGSGG9fs18s3TDTR2mgKSi442tfnJxhlsK9IeBLmNqGp+bn2ZC9TZ?=
 =?us-ascii?Q?jxdy9/6szrYbMBc/LoBkokQHbQo1WUJBkFXPsZvA7yLLORmTqUqypQ5AEK6Z?=
 =?us-ascii?Q?EsYqovr12ulghv6j/3I9BWnVRkAHMH0ef65wJEmdLij+YDYdkRNXjQrlNWdR?=
 =?us-ascii?Q?TQRmRXxgxv73znFAEC6+jZsSuxLwMtSMb/MnbvVAsZMNh+ew9PWplOBg/uxM?=
 =?us-ascii?Q?2bFl6P6OoBvmN/3JpdJj1HTxtSixRfxufEWewhFJHy06tQR1Xavkg7CFelRv?=
 =?us-ascii?Q?pCxdTGaohq7lz049Ge8+k7uctl/3T1dc/Nf9Ff4prc30GwCxoxc1StQghkw1?=
 =?us-ascii?Q?4PA9JhllCvYWdc9Wn/sPGNc+oOg8NwWJ7M8wkw12zfQmYu26NjlyqOMbZ+7v?=
 =?us-ascii?Q?JhUkNSICK7bMcH+TtOKj1zFIBOjqiX6iEp5pP9/yK0GNi2bkI5BwKTs8x6wY?=
 =?us-ascii?Q?Xpig+ZIA8kU8toBkkWIxHV2lBOxfQYPFaFmIAK89z6dRZXvKdN8ivy5iXeu2?=
 =?us-ascii?Q?wO+eNBco4ed7PUM5GM4L2XD6UJ955Y4AgJjGjEdov1KDKcvsIuuM220/Rfmp?=
 =?us-ascii?Q?IX8ezYXMNu9GdOKI8xRjKqxoRuYu2mMx/xfj9GLsmFQjyRpbLQRBxuqhl97G?=
 =?us-ascii?Q?TxScQSkKEFplwEylrWRnBO3r0v++G5NwJuY9DN72jLRFv01ClYwmNkxtXu63?=
 =?us-ascii?Q?8ykuWSdD//MX78JvwWvpmhw0YhWcH1Hf3QmbdzOM6dFYp4Asb1isgToVgC+1?=
 =?us-ascii?Q?RbZzYpeOqZHcHwy8GI9Eq+7AWUdQgWPMstDEYl8RPgGXGdibksthhJPsg/gy?=
 =?us-ascii?Q?ISu7UBDwsEjHc5M4Q77ec6eq8kFhkrz+EPoIA4qg7GiKRXhEfho/C3ATi06J?=
 =?us-ascii?Q?r0AStwvVX/HkbUFNz2V6xhT+vgtkEEW/4e73ZjERaxzMLJvKtsZbmd29I6I/?=
 =?us-ascii?Q?su5yd6kOe2jfxJLGAwc5rGBMFBfu7ArgVNwTQemTgnqXJfsJZ8B4Y3/aIbqo?=
 =?us-ascii?Q?7RFksOqBzAFBaV1fy9EFO5PccbWqtkZ2m/BxZgZy18YerbDbIktNxvVIXYNZ?=
 =?us-ascii?Q?TNbdfMraG+D1gtIYlgWZhHWVqYFESDaOsxWGwZjejn+BUscK1dbUSHoZDcHA?=
 =?us-ascii?Q?kD6GXSQwPXrI8oFtKHmOivpoYmTBP8vqRT0TzEBt1kTsaKuQR/tEBAv5o6wz?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9520a668-0ecf-4ffb-a7e3-08db89f53d90
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 14:17:39.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0hH791Ud6nd6evw6VnHrqy1V7SM6lqRMux2oAOoyyydiWPKlzH5QTZd9LAdT/+VFEkjSjo2Dbl2RH5glM2AAdTozR+zgx+v7AVZFxsNIkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5422
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:44:11AM +0800, Lin Ma wrote:
> Normally, x->replay_esn and x->preplay_esn should be allocated at
> xfrm_alloc_replay_state_esn(...) in xfrm_state_construct(..), hence the
> frm_update_ae_params(...) is okay to update them. However, the current
> impelementation of xfrm_new_ae(...) allows a malicious user to directly

nit: impelementation -> implementation

...
