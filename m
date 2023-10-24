Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD797D4504
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjJXBbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJXBbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:31:06 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDAD10A;
        Mon, 23 Oct 2023 18:31:00 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39O1LSmS032325;
        Mon, 23 Oct 2023 20:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=c9q0I8kRzfpJB4LFximif8d5JDVLEG57pUSp6thCG
        C4=; b=DhVEmLrpSbve6OKNTRpfBjQASBzakbQLwoYhaRXKcqptwT4Q211+oRMkS
        smdO2C00Najt1mjn8bgc7GS81/UoXr1PKXEqd/aTbdqDbDGLVUFwiNzZiEuaf4ui
        NyQC7AEWjn4IB6HaHl7FDnx3yuMvw7mHwY9fTW1l03cXcxJXHJz4SYZloxLa9mtu
        WEjjrzyQUQbNRiMivKpbZhTvU97PIgpGmzp+hVqCZjrIDNeN0TxaqUR6q7xnkqtG
        tU8ht3xaj4p94B8PsoYSEFyo1mpGTnd9lajh/Ao8RqVvLUBV9L4avpUvOBE81chz
        5QD6GOPDEI7AoNzknQkd7rjMesj8w==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3tvb2j304k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 20:30:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRbQobKHjJDlqsX5vGUU2P+kXNnU+rkpIYwyQk8VgE/xQM1kxuL+yQjRdWlQoieW9TgJfuQcZ581BiaO399rfWlYVGoRIjeWVLolN5LVPty5JgOz+Oixxd9wZyv+Veb7AczdB9MOhNQ4m17Zqic+hSTMTZ44bgT5U80+QquEZAV5ZUg5S7BMVpyQPkx72ZWenUfqZzS77Wl5vY+bM9gmUcxfN5aFHqu71DWPPq3oZxfqXFmArmxIRlmdwxn2OHXMHqBPubpw7NbKfplm1vhCBgwv+LUgchR2O243E1eZ4MWO95CcYeAU6i5AENQLhhOrOqUjdJQTheeaQMYRk8cwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9q0I8kRzfpJB4LFximif8d5JDVLEG57pUSp6thCGC4=;
 b=FYtxkU0VL9Q9ZHMBRqOXH4ykPhNq470+U5EZFo7XgQeq38uVghJm9TSd4C/1zapgm3STFnyGkLHLUVIddZcoTO1R30idkMMByY4sYWzcfH3WSofpnzp2Kmj8uts0c8V6GQ6KobVwzYNIqoqoTtt56MKN+sEAdgy06z1QKI7p0pXamD68QuOo3JgEnxt0DM/KQ7lk4cU5/naAjG/1snoaFsJaWfMGv0rLWo/8d7IVabxSgouMozC3mtPwDvgKu1F4GTSIdnl1VZsNR0JtSOh6Cm6GdGamGCGEtiSXEUIM09htghfTMXi8Gz2VgzB/Ziyv0d7zX2bv6UFChsqXQZH9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9q0I8kRzfpJB4LFximif8d5JDVLEG57pUSp6thCGC4=;
 b=TBxWvjtfG6hwLg5W2cjMbheoRKtyeXONF79ABKw3bc6pqgmNfhk0XfW1vGxPydzOlCS1FbvBG9ns+RzzFUAh117R6F+Z993ua2i8/qbE2x9xU2z6fIqWivhoFVMRb/rg5KZ5H6zXTVlwbi1xNXMJ3WxrMnGSsDwI1Y//zVcVOuE=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by CH3PR19MB7660.namprd19.prod.outlook.com (2603:10b6:610:120::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 01:30:45 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::8a74:6925:435d:19a5]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::8a74:6925:435d:19a5%6]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 01:30:45 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Jeff LaBundy <jeff@labundy.com>
CC:     Lee Jones <lee@kernel.org>,
        James Ogletree <james.ogletree@opensource.cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Thread-Topic: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Thread-Index: AQHaAeyf+2JrjyX4UUi0J9ryDkVps7BRTXqAgAGFxACABE1RAIABCOAAgAAGFQA=
Date:   Tue, 24 Oct 2023 01:30:44 +0000
Message-ID: <D8025A8C-8259-4EB0-8F08-7BF8B2E9350D@cirrus.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-4-james.ogletree@opensource.cirrus.com>
 <20231019162359.GF2424087@google.com>
 <E3224624-7FF4-48F6-BA53-08312B69EF9F@cirrus.com>
 <20231023092046.GA8909@google.com> <ZTcZIMbrFEhz+rm4@nixie71>
In-Reply-To: <ZTcZIMbrFEhz+rm4@nixie71>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|CH3PR19MB7660:EE_
x-ms-office365-filtering-correlation-id: 02860591-3d00-463a-2242-08dbd430d7b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jLbFHPeJwLCqYXAOeDzPzFFG+mwrqDhL8I/HUWAjH6Ebb8l8NDkKuMn0qsSLEuL9mkKaAKf70vgBrCTDie0/+gaH82W6BDSncu4lLQ8q1cgjERvw8EB8ragjkCtbRNe+VYdAY5IYsOtCk1q+KDy5kdEltvr/cuWWaTPLdQ2YCt8QTI53bVDCEs4l+xZEsDsARuJidI3x7hKg07uvcXQF2W5JdlorJ8ob1h66SsM5c5ibZR/GtMT5u6MMYelidpDpvrXP0eTySzKZ8Tl01KfkKzG0pgskjuZ+YZ2Jih3FKqB4bZqZJPqq3lRHsuTk26xzvaLY4i9mJLvW7+tXbUJEFRmU3tjbTFUTgFULhoVpipUs+mqRGvoir54J6LF6Mf+LVtmxCBVbRC2GDZaJo51Jev9q4kwpL4ENSHLwapSieKSsug/ZGfYhUl4FprW7lZY6n5n9Pk04hilbithTeoBq0lJy3Ye96j+l+D4gkBaXxgR53QT6xouNnoV9DL/XfMkmlXghnum33O82iKilGMRD5zDcaXHXgz6a1dm8hlv0NYaTUm8yI3sCZxuaObOs03AqGe+DHCVjMwlP0YghvNBfI6mO7rQs4nTqWzbDbnJyQ2bFuKfyJthLD2OPYIBbmrW26ELRxfIhyHVP5JL7Gqj9Dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(376002)(366004)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(8676002)(6916009)(86362001)(66946007)(66476007)(54906003)(66556008)(64756008)(316002)(478600001)(33656002)(6486002)(71200400001)(76116006)(91956017)(8936002)(66446008)(41300700001)(2906002)(4326008)(122000001)(53546011)(36756003)(6506007)(38100700002)(2616005)(26005)(6512007)(83380400001)(5660300002)(38070700009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j4MvfB7SPKRrLa9gF7o5wupWlPAntnTOn1ncAaugXlmDtTGjtxko153R3c1m?=
 =?us-ascii?Q?bRQYmpltdhRFGU6D+sd8PaLSBUxFc86jz5+miDc/HNw059K+LVi2H2DGRMYZ?=
 =?us-ascii?Q?2MFAyKfCzMGd+zEJpCZNTtTe0rR89vFPAOQMCJtoAT7ANR9lQcTqf1NOVNYe?=
 =?us-ascii?Q?cp1LlcMwyNz5pMALjf/dkODnMO8VaUEcfsQM87Cl5iZSZtpS2B3L/yTGkKtM?=
 =?us-ascii?Q?qdmUt/4jnW+EiHImafDuy/8SdDzUj+FeO/Enn0P6sLTLejHFt7Yes0l8S1a1?=
 =?us-ascii?Q?sKRGfbgdOmFauI9dS8dutVpFIV9PpX4hh4JgF0Ftl9YBVWjwnC1++ZUiIbjK?=
 =?us-ascii?Q?gG22dxc3KJSJociiJnoxpTSqRB+qDz3z9TBgBazYngfCmF6pAiAPS2+Ax8B9?=
 =?us-ascii?Q?ykP3RicEZA2x9eJFcGOtnLpG93Teq5uhZb5hq610RXhnD2i7741TrN72Ur2s?=
 =?us-ascii?Q?nPPL8egyluBVtEEszbYjJ3g5Ao0mv1bwgy+84Ca0Qs08g8c+VTI873joNBxs?=
 =?us-ascii?Q?4mNzQ3RZfkUeStoJLCoZbjfkBGCTKPe6FK/DZwYldHOfBdJ3Yr/kJ7i7zEtX?=
 =?us-ascii?Q?ZWH4wjPya16yAGYycaU2SJCasbi5hfh/DHNjMUWbpA85zr5e6kNRCD81owgV?=
 =?us-ascii?Q?5pj7kylMjfG7mXmWkR9for7um0G7O1e9zMSi5kWBSpSG6dru2rI+CAb5rKrL?=
 =?us-ascii?Q?j/FHpnPkk0Sh4FZZ9/1TJo7qziMnzisZ1OjoYzrxuYVvzcq99DZ+EqYQ7MjY?=
 =?us-ascii?Q?lxeNBsAI7wpCxHKQ7S4MELCZMiVssMIcR5/AiOiF9lT1grn5o6QfUjAGbfeB?=
 =?us-ascii?Q?N7+k0PFFaPsfiSxhDaGmKKWVtO2GtgJ/UwYEv4kn8soyIS5fkJN8nkouoVNK?=
 =?us-ascii?Q?1M6Z9leE1g1cpx/lWr4YG2kxYVQYhChViSaByaBprflKot+/yTgMFki9louz?=
 =?us-ascii?Q?GgGg+T5ajV5BIjEcgubGwjIp9RHfjF7TAVX+Qp6sAyrPVu0SHoyoulb5n8yH?=
 =?us-ascii?Q?TzX8aZovoImnfyvBIcB7ySgJtk8UTUvNSXTVrXBmXXkWD3ir8icwj/HT3aRn?=
 =?us-ascii?Q?zPTG82puYc+MxTQuWhe652MP46GFVKR7H47qCvaLanC3xLwJ91w2prHGHepY?=
 =?us-ascii?Q?fmnXsON7yDl4s9sYSP2V6AOKpLaOOw7D2Ze1xDorAL0XNlq/tzyMWNEAjbRk?=
 =?us-ascii?Q?2WvvHuqV4w9CcDB/BGe6OfgPVrZhgQgPaTP780vvptsNUW0P9aIYzK3WWkmZ?=
 =?us-ascii?Q?PSX7RuPwRxZDMjqL/f/AhbBh1nEuE5ye2r2mjCWnQ5CZzej2rhl2v8Uxvu6Y?=
 =?us-ascii?Q?nHE8v4/MKPszwQ7TFVGP4IWyWHcgaLhfRbVX58VYGVR0FD0tGXwTmOAM1rXf?=
 =?us-ascii?Q?LBsyYPJbuScDv2MVwYgbXbTz50RY8ok1dnnCI9lAo0A71C4pzAwpRzB9eHRg?=
 =?us-ascii?Q?wEdFxL1VxwVWAZwHZ/vdRyDYiIDaTB/hhuwaTPI9aqSUi25xJ72n12M8sRgy?=
 =?us-ascii?Q?UEOp9TFk38teoC06reZMGG44SJBevHaZ3oXx2WLv7H+9XYcuto55eBYyu9/F?=
 =?us-ascii?Q?kzEuBh2ksGdips/MKHsR9+EG6BpKnhm/NDCNygWng9iqD7Ay4ywnNZgaJQEY?=
 =?us-ascii?Q?xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C261B374B23D534EA78EB613F8831779@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02860591-3d00-463a-2242-08dbd430d7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 01:30:44.5180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7K4TxCfLTqL19VKJIm8ee4U/tw59XYshcqd2+EvXglgyL1hLEkc21QO7eCGhUOjupvv9XyWPNMeRIfievRNduGbUC65ETlQ81qr34GRFAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7660
X-Proofpoint-GUID: laJy4LmgSwjkIrTv_BWCNJb7z7WCqDxk
X-Proofpoint-ORIG-GUID: laJy4LmgSwjkIrTv_BWCNJb7z7WCqDxk
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 23, 2023, at 8:08 PM, Jeff LaBundy <jeff@labundy.com> wrote:
>=20
>>>> Should the last two drivers live in drivers/mailbox?
>>>=20
>>> Adopting the mailbox framework seems like an excessive amount
>>> of overhead for our requirements.
>>=20
>> MFD isn't a dumping a ground for miscellaneous functionality.
>>=20
>> MFD requests resources and registers devices.
>>=20
>> Mailbox functionality should live in drivers/mailbox.
>=20
> I think this is just a misnomer; the code uses the terms "mailbox" and
> "mbox" throughout because the relevant registers are named as such in
> the datasheet.
>=20
> Please correct me James, but I believe the datasheet uses this language
> because both the host and the part itself have write access, meaning the
> part may write a status code to the register after the host writes that
> same register. There is no relation to IPC or the mbox subsystem.
>=20
> That being said, some of the functions currently placed in this MFD,
> namely those related to haptic motor properties (e.g. f0 and ReDC), do
> seem more appropriate for the input/FF child device. My understanding
> is that those functions serve only momentary haptic click effects and
> not the I2S streaming case; please let me know if I have misunderstood.
>=20
> I understand that no customer would ever build the to-be-added codec
> driver _without_ the input driver, but the MFD must be generic enough
> to support this case. Would a codec-only implementation use f0 and ReDC
> estimation? If so, then these functions _do_ belong in the MFD, albeit
> with some comments to explain their nature.

Thank you for the clarifications, Jeff, and you are correct on all counts.
I see that I spoke before having a good enough grasp on the mailbox
framework. As regards the codec-only use case, they would not be used.
So those functions do belong in the input driver.
