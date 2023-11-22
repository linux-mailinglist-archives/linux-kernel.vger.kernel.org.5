Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BB87F3C7A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343593AbjKVDjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjKVDjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:39:11 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2106.outbound.protection.outlook.com [40.107.113.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2461D90
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:39:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dz49gjY15xvcr108EyrKEIA1Z0c+mVZYYEpPhmlXfU4Q18iS2gMClZxfQNJgwfTSB7UHvIiwYmF3RWeIMT6cGva5G2h0QfU6YzCOA+hVpoXrNjGeLfLSUR5VMyMuKPd4lhZfehbiC7bep4PSpV2C+C/IzL67xIgT9ikXc8/dX9H4L1ZetmOnejhg/gAgSGux1jzZk+//wtF2EpTxZYwcWfJN9VTIMe9wG/QWbjrgtWgBD3QstcoPkBftDjW7zwxbkbuzvdvAdEFzDOtzxPH0IwNLOLJnsEN9M3ZDtiihO9VbRhcCB9s8Rc4Q4GFQ2NeCjRh95UgneR2oStCVSabAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMxsqSZpjcaeaiHjF58SgRDCva2dKXaSUVNl2hsgcRY=;
 b=QkL/AhgoBwXKjo4Ipcc6UN+KW29Gphbp2QqCYYZAfhHm8Uvt6uUVmogR4vZxIvxCIr2SYNTeynmwmQtSlHE/vPhPz+//TlDzpRiEv7/pG7FfCMAoKVD4vcu5leHThImn6rg13Jmtrs+HIqCZ1IynLT30OCBkMU72iCxaXd/W7u3NUsFUmTo7F/iH1QlPxRkV9+/QT7xrirRuRCzNOaupc3wIqJEEzprlP3BxjKwZSvfm4qw9lvkJe43eEkyj5OHpnqRhC90IDAe4MQQa8J/KhAAQZbdcimMKnJIyAFQZtUCIXXCSVmv4eBV8svZpO99cIYfuzo0Qq4BlWFjD/6hDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMxsqSZpjcaeaiHjF58SgRDCva2dKXaSUVNl2hsgcRY=;
 b=lXf7M5mAlO4h9R3bG9nDnbozsLqcBpnQcXukvxdic984Kg1GJGc4QheE7NEjk3vhJA9R6x/v2GU4H/sR0Yw1x1ELGI05HkVMKZGW3CsLWFiyUUP0XQ6e8NFlzxphduL0ORdB8HTBifPVwsbG4k3yX5Bwmfd6JFOvYW5XWphfN6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB11224.jpnprd01.prod.outlook.com
 (2603:1096:400:3bf::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 03:39:02 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::16b3:a84d:faa6:4846]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::16b3:a84d:faa6:4846%6]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 03:39:02 +0000
Message-ID: <878r6qh2y1.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iuliana.prodan@nxp.com" <iuliana.prodan@nxp.com>,
        "shengjiu.wang@nxp.com" <shengjiu.wang@nxp.com>
Subject: Re: [RFC PATCH] ASoC: simple-card: Use dai_id from node description
In-Reply-To: <CAEnQRZD8zbgRzBrx+iHTbDqG5tOedNLyJByNNtSHTRtxFsgyGw@mail.gmail.com>
References: <20231117163900.766996-1-daniel.baluta@oss.nxp.com>
        <874jhh2g8s.wl-kuninori.morimoto.gx@renesas.com>
        <CAEnQRZBb0ZJk7aTaji-xH2jEs7QiTaoXTuS5_K-ruSaxpEnWdw@mail.gmail.com>
        <TYCPR01MB109142FEC8F77CFFE3930456CD4B4A@TYCPR01MB10914.jpnprd01.prod.outlook.com>
        <CAEnQRZD8zbgRzBrx+iHTbDqG5tOedNLyJByNNtSHTRtxFsgyGw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Wed, 22 Nov 2023 03:39:02 +0000
X-ClientProxiedBy: TYWP286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::20) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB11224:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ad8021-bd38-4a28-58bb-08dbeb0c920c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCc2ZZVSxGuRQ3nzkX4O3YXLxITo2kcB29qz+MATwnHrI+WfMEMnEvlmZqg1SAvlx6+fbU1B8GVMKybrsuAg4qa5hCXeM5IPPdHE2bGhPqXu/oZ4l5EIzCDQG3GOpb9xQHLijSIlN5V6164/udDa/O+h4/rtH4dNpDkYqlFqKW2nJnOIAb8YPl47yN0AFTtnbmLq3xP9FS7896+XT6J5krCtOgT+gQ9DyXH13A9PCAdTUlUnPmsBTFKJh0gL/EC8H3q/e4Hkj8LiJWeriyLXaQw2YEyhmzgZa1tAY91qcDxp+dD25l2iTwE8SdKRmOW3k39cJxU4/4yNJfhI94hKx56vmen7kiJh0QKyFdKd0UzK9gadeSb2Ye4JA90iPIzlS1My82mu8ZCOvg4pBv69D7LUO+eoDOfyebmA3X9IKROVGGiweGj4sM8R2V7t7FxVzZdm4z/YD//NIx7JH7q00US061M0C6Xic11fCyRwI0toLncOLQGUBZ/kwCOm0oe8N6+llvk0kNWnXJvEinDUp6BoNMZgopb31BCVoJE3BeN7jtXJyPji6tYrCm2hPrEXswy8terFySdOxnYQC7lljoXDNg7b+yjoI6SPj8Yh+mxusTlulJ2uYkL+OfcyadWD5Z8XoiX5BRh5r+/Ar1104w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(52116002)(26005)(478600001)(2616005)(6506007)(6512007)(38350700005)(38100700002)(36756003)(86362001)(8676002)(4326008)(2906002)(54906003)(66556008)(4744005)(83380400001)(5660300002)(66476007)(66946007)(41300700001)(6916009)(8936002)(316002)(6486002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0+A/jfH3I3Hl7IiWK3aQbR5LIDNPw0gitJWSaodwCDJomGRGR0mQFZoxCybu?=
 =?us-ascii?Q?Fyi1rKuiVsiwE6QF2xyZ0FWlyiIlIg67vxf8jQmSfkke4EXTr8oTfL1U78Xx?=
 =?us-ascii?Q?iVG3zMw96icFUK1bIUsIEF8Ca/ewaaHrMW0bJPZ12dfKSre9xzSuz4FNgQK/?=
 =?us-ascii?Q?HV/yqHlNCDJ/BPoplbjUw3CNQT1xzdsSafn0mAY7mM+eT8GXwjiPp9oa6t1M?=
 =?us-ascii?Q?xGHltnu7WqLmAjw4oWD2Mf62FbEnztxgEGFtV8jid7hbj/w7b9xXc337OfS8?=
 =?us-ascii?Q?3mv42s9kyKc3t7Ilwmpi+2oaGmehPPjdphclATll8xNIRInf/h2fjiq8HxH1?=
 =?us-ascii?Q?wkqqu91cyuBKHeCByl7SYaTtR0hd6DBDSxFwj+bNUnOMaiMswowLsJZV2e0Q?=
 =?us-ascii?Q?35sxdoybNTo4FpwDLpYLxhvEQI91u/hOB90weAR9ER3sNB3+azS2UP1rl0uB?=
 =?us-ascii?Q?8NyGql85wDNr7UacBjEindMbZgJPFb4XyqKIscLJLT1NF7LTsylPSZxdRbiV?=
 =?us-ascii?Q?vBc9JZFF/YpcWAZ2gGTUsJz7eu2xVI1rwlaMJJNqMbx/egMjs4FMxOrmXYqT?=
 =?us-ascii?Q?gCZO4dz/gunPyi1lAZJe4HPkGjMKj7jcpdcDkkkhybvOm8g43uj/ehqs8JeK?=
 =?us-ascii?Q?19L0x6cw0UdnR6vFjx0cOIlae27YxRFV02/kuwqgoVXkrJ2Qnde0wIKHGGDF?=
 =?us-ascii?Q?nO+I7Ql/lWgsn98BIhWmHcEGAZLmDtlhteQLehsrI/D3mXHo1pqcyu7IFNZY?=
 =?us-ascii?Q?cL/h5n1pZ/1Zu6JZhsrXR+k3kZqexTquh/EShR9Qb6rIWB3+SCfsWPpWMkN1?=
 =?us-ascii?Q?ajILT3egyJSF0OXTkIorvfdTSVn2zSRYxbu3oDRsvVDGj3Xx8dko6Mu1odLZ?=
 =?us-ascii?Q?0M+SdQJcWgDbvQMZ/E3+AaXnHM/eZHpfyJx7qcAnyKgk/mBEI9CCXsl1yeIB?=
 =?us-ascii?Q?WOZwFSl5GlGUyKiXfVaRNkd21xJNyl+ZEWKPF7P5ddjH0l3ZAcL/Li3BVugS?=
 =?us-ascii?Q?EdxbBYkawFmIYRbWK1Vouj9pbDdUtZrCYFM3tdAKM/nUeMhjVWB+eg5Sal+l?=
 =?us-ascii?Q?74592KvZwLxn2tV17QQnnQprIZFezrQLQlPEBR6nbD9JOPIECursDSYb1HOG?=
 =?us-ascii?Q?ORje4qox23rfE72iZHaCyyQeVk0CRaZftHsBMputgQorQtKH2iVluLt115Wo?=
 =?us-ascii?Q?IQMlDXwtxZ7cUmelnkai7N6GtkADPkHlTpBgbIT6ylFCp5dq+yZyFLirBfX+?=
 =?us-ascii?Q?mw9xJbWf66cpS82tNU0NcITJnLrKspDdALYz9k2o+nqHL3nVQTxpy95S6Fpn?=
 =?us-ascii?Q?XOD9BZHOSYK6Idz553NxY77kzoRsntz2SsdeLZwlXoPMyt+A9RQZ+7X/OJRQ?=
 =?us-ascii?Q?pUIEEzj+Fs8c41GL/S7dr1qevFznXgPhGSb8JXYiyKpTIHdhVqdhkmQ6+wt3?=
 =?us-ascii?Q?m0t81evSDKVYt7H68Jb13LyhDv8i2PEeyZTsNzFqe0ldIOfCa7mBhRJgH7d4?=
 =?us-ascii?Q?b4vBRm6YTj230GCWmWXqI8dDhxgZuo4Yla8jhQh4rul6jsmbeyzN3NSigSHQ?=
 =?us-ascii?Q?g/JEowWfW1FujHMTXuhLF/sKIvwqH10mhqfosaDNhz5tsIms5/qwNfIkTafK?=
 =?us-ascii?Q?dcxcNXL76iycA2qlU5dOgl8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ad8021-bd38-4a28-58bb-08dbeb0c920c
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 03:39:02.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iglFpBPvGNWQN5OdBhB0IKb6KSBhZ20YvBCzzNrMlYdWfMZ50FmwToWEl1dkgVXL/8CoYmO1xxp+gdqmzpfGv+9uRNOuuyjduuZeltL6GwWR0c07IEi8lv9dysF2irU1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11224
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Daniel

> > But hmm... in your case, you need to setup 2ports, and use 2nd port
> > is assumed approach.
> > Why you don't setup full port ? Do you have some reason ??
(snip)
> Now, I want to write a DTS description where my DAI link uses
> Component 0 (CPU) (with its DAI index 1) connected with Component 1
> (codec) (with its DAI index 0).

Thank you for indicating your DTS.

So in imx8m_dai case, it has total 3 DAIs, and you want to use reg = 1.
In such case, your DTS need to have like below, if my understanding was
correct.

	dsp: dsp@3b6e8000 {
		ports {
			     port@0 { reg = <0>;         endpoint { /* not used */ };  };
			cpu: port@1 { reg = <1>; cpu_ep: endpoint { remote-endpoint = <xxx>; }; };
			     port@2 { reg = <2>;         endpoint { /* not used */ };  };
		};
	};


Thank you for your help !!

Best regards
---
Kuninori Morimoto
