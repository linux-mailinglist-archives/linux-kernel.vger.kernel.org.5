Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1527942F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243796AbjIFSQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbjIFSQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:16:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3665172E;
        Wed,  6 Sep 2023 11:16:51 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386Gwvqg028239;
        Wed, 6 Sep 2023 11:16:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=fJEd1ezDgnfImheXBjdI2iWg7dI9D1pbzBgRRuJJZbI=;
 b=hdfkmbsTVazqXG8q4/4cRoxpl2Ie2J8KAVYxX27DWBWGuqogQo0EMswlLw2tIG8qeTe0
 uL8X8A/8ad3/DsitTXFTv1BWjmCxJHKjcu9U0xvWRME1jqxvnVxCdkt1j5FVL9cBIS/J
 VQbqybGbYIOvsoyo15O06JBXbjWDLINi+mCLZIehrHuFJoWoOJDGZtD6m2mDF47QdXG6
 uNIasphBU8RSl71kI/4T7DF0saIX0rLaPGvgEbNh/xNLqqs5BwPLut9vboz/2EU6SceM
 9nziizu6kAUJ5lCGAP25Ubf+m62po1LiVo7FYXjuoPoHW2XsW6hTzXn87erXA4s0NTJG VQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sx9spc0wm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 11:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcjh3i0neru2s3mCPV43USSo/uClVB/oDeCltq4cdWlv9CuNtyTtOWKQfaMDygj8G/9xCPjEnWoaZliiBODCLvJ6JKpQRGsycB5O2a3ayJ1NaDH82UQZVpIstaztRuHqcqI7W/TGEsPrHdP4kqinqsHb8uI14SJspAnbfebYRnty0YH5CTnaqKaiLdxg11Th0tV+joB5lfT+RnitxOfcVIPjUvC1xbvZM8uQw/31WBVov0xlGCUzMtqr45BZbhL93DG5yCZ4a0BrQsv4CAOy6zx9wccnzFQsSrDFHpxn+TRYFdUlEFFpazk//85wPTdgP74VTp53HewYyw7OjB5/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJEd1ezDgnfImheXBjdI2iWg7dI9D1pbzBgRRuJJZbI=;
 b=XkOMyG7GldJLU/DBTntnXXeQQDPF9qI3RJeHFIhXCyoYRBirhIlRuwbLo5RKnhSm60gRIB/zgk89JDwBsZA18fN1aYT0zBLjN8MhabWyQ9ZeXxnwigObjGi0N22LZvta6KJVs3A7Gjauyyks5ovIVH5CyBjwfh43xRDVfB5CoWBVUcq/z5EhhTZrNcQBjIQqeGCSjXr8ksa16OyyqP3ArjdqgXSyjERHf8Vgwbe9qDxBn2dsR9I+5GQimon3EGuEj9S/F5nWsXZlxB6uwmRduEp/R86uC+oWHYYRJyPli0YapIPT/MvyDCxqSjwQ8RsBOhnaaRZse6qUu54+IrUhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH3PR15MB6238.namprd15.prod.outlook.com (2603:10b6:610:163::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 18:16:48 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::57f2:86c6:1115:ad7d]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::57f2:86c6:1115:ad7d%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 18:16:48 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Song Liu <song@kernel.org>, Fangrui Song <maskray@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "x86@kernel.org" <x86@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] x86/vmlinux: Fix linker fill bytes for ld.lld
Thread-Topic: [PATCH] x86/vmlinux: Fix linker fill bytes for ld.lld
Thread-Index: AQHZ4OrqPJy3Kaf4C028wIHQuPVKirAOF8EAgAAC9YA=
Date:   Wed, 6 Sep 2023 18:16:48 +0000
Message-ID: <34CC4A68-CE36-4DE5-B1A1-AB7FD075C0EB@fb.com>
References: <20230906175215.2236033-1-song@kernel.org>
 <202309061102.DB794AD295@keescook>
In-Reply-To: <202309061102.DB794AD295@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH3PR15MB6238:EE_
x-ms-office365-filtering-correlation-id: 5df967b1-139b-44f1-1f14-08dbaf056f72
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eTA2YXxHHL2Lpsb6/P07WXGbV53YtGX3qo4Np8XSYzZs4z0foxF2Dt3+Dm88iYyRuI5IMirkFe0R5teldz0PtC7ZfxWInr903Rr5ztlhmAtYZMZ5aJD3m4uRHBnKF8YB0k9i3yjddXgUQztpAtwCjbH55q/SjFolmME/nDp0x0melWgZDuSHSJn97QiTA/KX1sBA3U6MTz+rRF0BirMkbH/3wfpXiRc/5+olaMUR+gBnTVbC4rlf/7XMZ+BRphB73T+5j5fc/yCkSqkpdSDfm5TsQXHr8gXQB+LfuDx+w1WrJl++wE7+kjNAUf4ADp957F9gJ0y2Cu/gl+ueYhqMKAo7h/dwz1Re+HAdLRB5dzsbuOCKnq6wXRsj1YDBWYXvxcknC4MgskYzYyHeR2tK9tsEmJEpn8FQFqjwbuzlNxTy7Nba74RFG4mjncvp4yQsrucWIjy3WsaZWq/3JYjyeMeiJOXqXE4gvgCUUyn4T/2Z5VjsvskioR+/Qau9BM7di21gduTpyQxdTKmDv4Xi6ozHtImbigj85URqmqS2LSecso5TFXxEBKj9AibXaVh9bnOsLwczrT8U8MaGbVkxX1Xz1eEmq20BM2jn4s/3Vt3TXbdJ7V//p679Q19zlUPB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199024)(186009)(1800799009)(478600001)(71200400001)(6916009)(9686003)(6512007)(6506007)(91956017)(6486002)(316002)(4326008)(8936002)(8676002)(41300700001)(2906002)(5660300002)(54906003)(122000001)(64756008)(33656002)(36756003)(53546011)(66476007)(66556008)(76116006)(38070700005)(66946007)(66446008)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ia7J4WVENWkQ7sbc3smt+wIYIfCAgwoJjuNMCS0ibl2z09yVornDuSGI1hyB?=
 =?us-ascii?Q?uejHM821DY2br3Cl/dxSv38zoO9i2sB1nFvky0AZCEAeZPNODGlJzPG6KUjT?=
 =?us-ascii?Q?IiAeKcOpUF2iWH8sMEaBtiFrietflnro6NCg+ufMP+4GEfYxBt24y34rHW8t?=
 =?us-ascii?Q?xIbqfXawD5FSKWtFARWBnIh51IYS3g0WTTCF3pkSD4FFYk9Ip+UcDrXvkDoc?=
 =?us-ascii?Q?GwMZMA6wUHx9Uwm3MAB7qtI/BgwdfK7Y8/jmdKAKViFYCtopFXZA5qalRTd8?=
 =?us-ascii?Q?3fZB9OocKLrmdd+cnrj6QO4CcXQIqBcD0SP7cc0swkjatPcmN/KrFH+hvj2P?=
 =?us-ascii?Q?DqO2baORA8ben4H4sy91BVZHYT1PF7o401AvSW8e6JKVRp+RjsLE9RouXzTS?=
 =?us-ascii?Q?f0bKD6/3WhaLlk6Z2/TU4UgkpUvVGI8I0zYfVAfoRgqrjFLs4zihHyJmTNq5?=
 =?us-ascii?Q?keX3UXz6CI7srZOl+yfOutiJI6Ft0fHY/7fz2EKN1Fga7HA8WdZMXIISG54f?=
 =?us-ascii?Q?rUgWC1XS1nAhqCDmYE3wrDrvGRZkidpE8PPhYSWHBU05f9JwisY65rsdZDiB?=
 =?us-ascii?Q?dhmBcEU6OSOQ+lCEySnYmci6IEBO49muGVWJ0B7OX8iTAJrcCua3wk59jPK4?=
 =?us-ascii?Q?McSNKiS9P7zIapgYmUr+7ef+Gr9hKfUwYlLXGJrAxFu1JXCUaeDsZSN1Ix86?=
 =?us-ascii?Q?ntSf7gbm1VZG+4dYhnlTh8Ugdbbk1d8J+yXAktJrLU2C2j+D+mtrM7Z45YAA?=
 =?us-ascii?Q?p+xuWq51KRyeaVwBI+1/8VQ24ilYtrfDd791kne+ahJfNbKHxD5tlwDFhL5C?=
 =?us-ascii?Q?FLC0mOK+PfShYtXXyH9PPU3XfzTwCfer/6oqXdWvBDl+ocD4+YULLw+8VCW0?=
 =?us-ascii?Q?L0azwPlBNfBMPikJxbQiO9luDjXl8e7rIGtWN/i0c/8+u2VEVpuVNn5fYFSZ?=
 =?us-ascii?Q?vK7nr1TwUUTFlKaFw3RGQmws4GSKj07gZOL75f3s63Pb2uqxQox++AeqXE8S?=
 =?us-ascii?Q?F9TOQl6gTZRMfnidNFt4hcG7yXaiIyEl/LM/X/URMOU5DtneHuBE41/wbCrV?=
 =?us-ascii?Q?G1ZDWgONZVyuzpV1XUTumydx7t747xakLh9cU3bH8GpHYDg61fX5V9r/FMga?=
 =?us-ascii?Q?C1PesxkBtzPH+shYk5g4rui4Gqs0mNPR236b0fpg4OCIVhQIjgfGWhBc7DRx?=
 =?us-ascii?Q?ryV2PLpfFAf8hyKoQt84BIMciI3MpGF7ThS22rgLLfqvY12ehk5kfHjNa+Xk?=
 =?us-ascii?Q?jOIlsAJu9FcJK7oOT7kUcAl9QVdycgWiUgkYMwXD2UCr4npHzxVBN3YjaKzp?=
 =?us-ascii?Q?Qb+URAlx+AMSCS1ahC42M9fvZ4EwtAa6nX4g6EP9tNCTqhxPnhMrL/mGqi/o?=
 =?us-ascii?Q?mQQ0cJuF7iQQsxX4bvR5pmkkn8Gicx6UySOXpRRJBDnpPDdP/6eg/wR6fnZz?=
 =?us-ascii?Q?x1hE28eei5UvpIAtm4WgLLRZ89MZhn74MTNFeTXlXVGsMns53Cd19SvAQAXX?=
 =?us-ascii?Q?8eH2886hMgCOjle5FiNl1tN54I6+4e0WGukLT+PAj/rWpzEtngMjPcxwh42e?=
 =?us-ascii?Q?jcZue/s5iyXV8jnLzwIvV6mCg7UjSOCo3DFv1w402DaJ4YDe3w3RDPGdh0DH?=
 =?us-ascii?Q?kL4GjA5s1M+hlYe0CCYzD5A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5A411F805961D40B1C6ED72C37CA263@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df967b1-139b-44f1-1f14-08dbaf056f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 18:16:48.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uT2VXQiSkCejG7/1OtNFpmrqeTnX2uTb/LRY8kemUxwfQv0v4qfXrzi4Ivc7KBdTXy8mQY95utpgusMhAAKCuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6238
X-Proofpoint-ORIG-GUID: oAfsCICXy7Ns8UuxxXZGyTwEEX5JF-qg
X-Proofpoint-GUID: oAfsCICXy7Ns8UuxxXZGyTwEEX5JF-qg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 6, 2023, at 11:06 AM, Kees Cook <keescook@chromium.org> wrote:
> 
> On Wed, Sep 06, 2023 at 10:52:15AM -0700, Song Liu wrote:
>> With ":text =0xcccc", ld.lld fills unused text area with 0xcccc0000.
>> Example objdump -D output:
>> 
>> ffffffff82b04203:       00 00                   add    %al,(%rax)
>> ffffffff82b04205:       cc                      int3
>> ffffffff82b04206:       cc                      int3
>> ffffffff82b04207:       00 00                   add    %al,(%rax)
>> ffffffff82b04209:       cc                      int3
>> ffffffff82b0420a:       cc                      int3
>> 
>> Replace it with ":text =0xcccccccc", so we get the following instead:
>> 
>> ffffffff82b04203:       cc                      int3
>> ffffffff82b04204:       cc                      int3
>> ffffffff82b04205:       cc                      int3
>> ffffffff82b04206:       cc                      int3
>> ffffffff82b04207:       cc                      int3
>> ffffffff82b04208:       cc                      int3
>> 
>> gcc/ld doesn't seem to have the same issue. The generated code stays the
>> same for gcc/ld.
>> 
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: x86@kernel.org
>> Signed-off-by: Song Liu <song@kernel.org>
> 
> Ah! Thanks for the catch... I wonder if ld.lld should be fixed too? My
> understanding was that ":text =...." was defined as being explicitly
> u16?

Per my experiment, gcc/ld gives same output for :text =0xcc, :text =0xcccc,
and :text =0xcccccccc; while ld.lld handles :text = as u32, so :text =0xcc
with ld.lld gives:

ffffffff82b042a1:       00 cc                   add    %cl,%ah
ffffffff82b042a3:       00 00                   add    %al,(%rax)
ffffffff82b042a5:       00 cc                   add    %cl,%ah
ffffffff82b042a7:       00 00                   add    %al,(%rax)
ffffffff82b042a9:       00 cc                   add    %cl,%ah
ffffffff82b042ab:       00 00                   add    %al,(%rax)

I am not sure what the right behavior is per specification. 

Thanks,
Song


