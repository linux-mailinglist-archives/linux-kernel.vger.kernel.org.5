Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2B7E5B17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjKHQXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:23:36 -0500
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7EAC6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=544; q=dns/txt; s=iport;
  t=1699460613; x=1700670213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7wKJeoPXSn2vezcjQ2TVGJ3jhp/1RiGpcrLulXzpIWA=;
  b=RZGs4wLIi8Vf7CDVgMMUw/u5n8NSpzsDvV3+Jfax5FkJf4ZB9bD7XJhF
   f+DAbnSNHudzeMJnPn43GMYCq3GWbwXRLCkEZV2bxXNXfZncyA07Z18Ma
   eNtug9tOtQodLdxuP35LMVtRmyvXL3vMbrAPMlmOaaLLMh58XIbmDPCHU
   0=;
X-CSE-ConnectionGUID: ykFnfjFuSruXP+pzlp3JVA==
X-CSE-MsgGUID: JIAiYzUfT5ORM6b6GxzPaQ==
X-IPAS-Result: =?us-ascii?q?A0ChCQAitUtlmJxdJa1aHgEBCxIMQCWBHwuBZ1J4WyoSS?=
 =?us-ascii?q?IgeA4UthkCCJYV6jEMciyWBJQNWDwEBAQ0BAUQEAQGFBgKHJgImNAkOAQICA?=
 =?us-ascii?q?gEBAQEDAgMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBAQEBAQEeGQUQDieFaA2GT?=
 =?us-ascii?q?QEBAQMSKAYBATcBDwIBCBgeEBAiJQIEDieCXIJfAwGfawGBQAKKKHiBNIEBg?=
 =?us-ascii?q?gkBAQYEBbJtCRiBMIgKAYoHJxuBSUSEPz6CYQKBYIZDiG08AwSCVIJ2XY0wX?=
 =?us-ascii?q?iJHcBsDBwN/ECsHBDAbBwYJFBgVIwZRBCgkCRMSPgSBYoFRCn8/Dw4Rgj0iA?=
 =?us-ascii?q?gc2NhlIglsVDDVKdhAqBBQXgRIEahsVHjcREhcNAwh0HQIRIzwDBQMEMwoSD?=
 =?us-ascii?q?QshBRRCA0IGSQsDAhoFAwMEgTYFDR4CEBoGDScDAxNNAhAUAx4dAwMGAwsxA?=
 =?us-ascii?q?zCBGQxRA2wfNgk8DwwfAjkNJygCNU8KBRICFgMnMgNEHUADeD01FBsGZ7wjA?=
 =?us-ascii?q?a58CoQMoWmDW6YTmD6oKAIEAgQFAg4BAQaBYzqBW3AVgyJSGQ+OIBmDX495d?=
 =?us-ascii?q?jsCBwsBAQMJi0oBAQ?=
IronPort-PHdr: A9a23:S9D3jB1+Vqleg2FBsmDPZ1BlVkEcU/3cNwoR7N8gk71RN/jl9JX5N
 0uZ7vJo3xfFXoTevupNkPGe87vhVmoJ/YubvTgcfYZNWR4IhYRenwEpDMOfT0yuBPXrdCc9W
 s9FUQwt5Gm1ZHBcA922fFjOuju35D8WFA/4MF95L+L0F4rNhuy81vu5/NvYZAAbzDa4aKl5e
 Q2/th6Z9tFDmJZrMK831hrPrzNEev8Dw2RuKBPbk0P359y7+9ho9CE4hg==
IronPort-Data: A9a23:Wd2WpKhcVCzpHW7Vxkyp2tNBX161eRAKZh0ujC45NGQN5FlHY01je
 htvWzzQM6reYWHzLowlbd/g9U8Pv8XTy9FrSAE5+SwwQn5jpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+1H1dOCn9CEgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZWEULOZ82QsaDlNsvrT8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 woU5Ojklo9x105F5uKNyt4XQGVTKlLhFVTmZk5tZkSXqkMqShrefUoMHKF0hU9/011llj3qo
 TlHncTYpQwBZsUglAmBOvVVO3kWAEFIxFPICWm8n8qdzWPbSGHx880tFFMyJdY6xM8iVAmi9
 dRAQNwMRgqIi+Tzy7WhR6wxwM8iN8LseogYvxmMzxmAUq1gGs+FEv6MvIIGtNszrpgm8fL2a
 8MfaDdrcx3oaBxUMVBRA5U79AutriCvLGMD+Q/P/MLb5UDx7SVw4arQPuaIXeavG88LsVaKn
 mv/qjGR7hYybYzDlmXtHmiXruvOmz7rHYEfDru18tZ0j1CJgG8eEhsbUR28u/bRt6Klc8hUJ
 0pR8S00oO1vskeqVdL6GRa/pRZooyLwRfJBEMM85gOj15HO/jahRXAWSiYaSuIP4ZpeqSMR6
 neFmNbgBDpKubKTSG6A+rr8kd9UEXVKRYPlTXJUJTbp8+UPs6lo0U2SFocL/Lqdy4yqSWupk
 lhmuQBn3+1L5fPnwZlX6rwuvt5BjoLCQghw7QLNUyf4qAh4f4WiIYev7DA3DMqszq7HFzFtX
 1BdxqByCdzi67nRzkRhp81WTNmUCw6tamG0vLKWN8BJG86R03CiZ5tMxzp1OV1kNM0JERewP
 h6C4lMItMMDZSX3BUOSX25XI5pzpUQHPYq9Ps04kvISCnSMXFbdpXo3NRL4M57FyhB8z8nTx
 qt3ge71XSpFVsyLPRK9RvwW1vcw1zsiyGbILa0XPDz5uYdykEW9EO9fWHPXN7hRxPrd8G39r
 Y0FX+PUkEo3bQELSnSNmWLlBQpUfSFT6FGfg5E/S9Nv1SI8Rj58UK+Mnex6E2Gn9owM/tr1E
 riGchYw4HL0hGbMLkOBbXULVV8ldc8XQa4TVcD0AWuV5g==
IronPort-HdrOrdr: A9a23:kfR5fq5wNxdRIznV5APXwbqCI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQAdcLC7VJVpQRvnhOdICRF4B8biYOCUghrZEGgE1/qj/9SAIVyxygc579
 YDT0EQMqyMMbEXt7ec3OD8Kadf/DDlytHquQ699QYQcegCUcgJhGkJb3f+LqQ1fng4OXNTLu
 vl2iMznUvbRZ1hVLXBOpBqZZmkmzTjruOVXTc2QzQcxE2lizSu5LTmEx6e8Cs/flp0q4sKwC
 zuqSC8wr+snc2a53bnulM76a44pPLRjv94QOCcgMkcLTvhziyyYp56ZrGEtDcp5Mmy9VcDir
 D30lIdFvU2z0mUUnC+oBPr1QWl+i0p8WXexViRhmamidDlRQg9F9FKietiA1/kAgsbzZZBOZ
 BwrjukXqlsfEv9dePGloP1viRR5wyJSLwZ4LQuZjJkINYjgfRq3P8iFQtuYeI99WTBmcIa+C
 0ENrCC2B6QGmnqM0zxry1hxsehUW80GQrDSk8eutaN2zwTh3xhyVAErfZv00vo2ahNAKWs3d
 60eJhAhfVLVIsbfKh9DOAOTY++DXHMWwvFNCaXLU78HK8KNnrRo9qviY9Fq92CadgN1t8/iZ
 7BWFRXuSo7fF/vE9SH2NlO/grWSGuwUDzxwoVV5oR/uLf7WL33WBfzBGwGgo+lubESE8fbU/
 G8NNZfBOLiN3LnHcJT0wj3S/BpWDEjuQ0uy58Gsn6107T2w9fRx5jmmd7oVc3QLQo=
X-Talos-CUID: 9a23:6ADoDmPYLHIqDO5DSSpJ8kAWNN0eaGDt9DTIMUugUkRXYejA
X-Talos-MUID: =?us-ascii?q?9a23=3Ay0PIvQ/BzT3b/nze4SdtDWyQf+VJyqWfGn0Drcg?=
 =?us-ascii?q?hgezaP3JfKyWlhQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by alln-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 16:23:31 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A8GNVZV024550
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 8 Nov 2023 16:23:31 GMT
X-CSE-ConnectionGUID: bL9gLLzSROqQaxzl/LzbHw==
X-CSE-MsgGUID: HtHzsQi/RvGh9NpV1J6z+w==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,286,1694736000"; 
   d="scan'208";a="7563186"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 16:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdaXcOQuMm9zz33nX2pSgOWGsMCnzuWRl47sTWh/he+6DchNy3htTeWHVvIetQekSeXHoBxR2i5M650+kZgB6qPxBNIA5ZsMN5KNyuyrJuG5RamyTxL9AsbhMFwPQszeyc65BfMLIYq8N6+MAX2Jh9Izm5/KRqHllcHtYfnfYLx82yixukA+lq8+Yxu5mZtnhpMoETDAoGzVYZFxP3+Y0qP4+6VCWkc366aMkGMr7I1UdNzN/3moY85xc17+dp2Xu6YdXdcfTM40n7Uw7/UxW7O84KYVk2c5dt/W60Fq7gw2TVW5LgiLniJ5jMYTqu0ETzESZlzt77TXKfYRxqiFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wKJeoPXSn2vezcjQ2TVGJ3jhp/1RiGpcrLulXzpIWA=;
 b=TcJfM9BvTvtgQE1KM8eDuZObXl02Q9nrm5HSDBAeYWpqjyxrqZXMfCWmveYjfyZg4h4g4wGzgpX3G9KoTh8EWuiP/ISwAx9HUUVksVyRc+KZXxkh6oDSuzGP/aJtdGhem+g1hIGBBSBHY6+6Zg9ZbFXmmjR0JkmEXrsdlfPVez02KJLWP85ig74yCeT5oZWk2/GygAJ1MXv6G8/JQCLj8atsVa4coWWXEngTHP60qYynWVXM1K9hLZVISZQtpEiZqXZ3S+vPUvNcxVaCbBGglBSsHlVsHSJtnJQVy8bnKLi8fevDQWYzFICar5xqWbDONw8E8/F+kqMOIjxkCKrpuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wKJeoPXSn2vezcjQ2TVGJ3jhp/1RiGpcrLulXzpIWA=;
 b=lSv2YE0ZoNxtz1EwHSvTF1rMNvHjF3fyOobinc3q2v7Htbdlt2ayBMvRXksh3dUxXLCPYEEvJx4j+rGuNvYsdLGUkY8E488oTMQaaFrMKvNKNUZioYOCBX2ti4VzsUQpNmBEcGy+WDXA/C+n8LeHDykq+ib+UcURjjLOtw9vBho=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by SA1PR11MB5947.namprd11.prod.outlook.com (2603:10b6:806:23b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 16:23:28 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::a59:2fb9:3446:4f8]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::a59:2fb9:3446:4f8%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 16:23:28 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     Pratyush Brahma <quic_pbrahma@quicinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dwalker@fifo99.com" <dwalker@fifo99.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "maksym.kokhan@globallogic.com" <maksym.kokhan@globallogic.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tomas.mudrunka@gmail.com" <tomas.mudrunka@gmail.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        "quic_guptap@quicinc.com" <quic_guptap@quicinc.com>,
        "quic_vjitta@quicinc.com" <quic_vjitta@quicinc.com>
Subject: Re: [PATCH 1/4] add generic builtin command line
Thread-Topic: [PATCH 1/4] add generic builtin command line
Thread-Index: AQHZcUkOD6ppc7o7REqMkKuIthkl5Q==
Date:   Wed, 8 Nov 2023 16:23:28 +0000
Message-ID: <ZUu1/xduF2lxWOmD@goliath>
References: <20230417162415.GF1391488@zorba>
 <4c420081-fe57-d036-ded7-2899c13738ee@quicinc.com>
 <3d127abf-abdc-02e3-7c8b-a39b901ea641@csgroup.eu>
In-Reply-To: <3d127abf-abdc-02e3-7c8b-a39b901ea641@csgroup.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|SA1PR11MB5947:EE_
x-ms-office365-filtering-correlation-id: 967736de-f3e4-49fa-92b6-08dbe0770ab8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t/cyji4kZ7/Oge6h8JqRZhWRFVKmbWf3aTi0ufDceYe7dsjLfxwKjJ7k/3shTR/qjSFku/7DSgk+TZkvWrEmaoBa4q3Cwd803jzkf9j9uSILWkWRIY3dSXm1ow/eKadgdFZKuVYF9wow/6bBMzbKXsUBGb4/OWYuBVBQ2K7xWx4YkbjHV3tTTDZ4mYDHdFBvd/qwvWuqczAzmGabkFeD2BdDVDFgAuPeA8dF90woiU12MQzdS5NhXJnK1PpbtKm2WJBXzl/KbCsy1uYYCrdJ8gDHAVT1RI7PD1XAJIDdtrEfTJj90WmmQky6aHzf0a4TAJsMN53LjjEi1ao/5qRe+ziFfC1hAkwaN1HhVY94RhcpSpk/qNz+EBIPaXxcJXfmzkyi1WBHZBUcxWfDzrge00CSYxae+6bhst1QfdYbV+GvjeReTcF57sV//l8w+4qmkX5MyiSjOT4+1plO4N7ky22smLaKXpWUmwaXV6m3G7S9tDb57GzAvpRSm/hohpI5l7ZbJ+tQJ789Ecn/w+XQp0UVeOiqm35mWnaNrWsxh0JaoDy7U15Wb2ruBWPcAvhlCIhItqp9ekh3FOG3ek93NHZcIQ/lSv4fs9CTCpAqlQHoQDt6H7YlLMYN0B1GV3caVeYs1b+NwU1cyIuTr3TNsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(33716001)(122000001)(38070700009)(76116006)(83380400001)(66946007)(26005)(71200400001)(6506007)(478600001)(66556008)(6486002)(9686003)(6512007)(2906002)(8676002)(8936002)(4326008)(41300700001)(6862004)(38100700002)(5660300002)(4744005)(86362001)(316002)(7416002)(66476007)(64756008)(54906003)(66446008)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SNTVO72Y4h/r14meuGBI+howSVDRV7ppyluR35Dle/T3FEs1CylOoAk5rxmi?=
 =?us-ascii?Q?Vab1THXPpvXlynbntbIlgQ6aMgVPRUpc9mj+gQBcCBe1+l71PAuu744F6imi?=
 =?us-ascii?Q?2ySkRCBQaB1cJdVtGiui+UO/pP3n1HU7XXGuktBe1MHxoIdrhzfbbgr1qNbd?=
 =?us-ascii?Q?EIuUKt8tzNqv3W172wOf1J7oNhLEaO45WPVuUsAKbEQF7yqpnxYhnq+WXytC?=
 =?us-ascii?Q?EfX3basHLFs6igsC7mWzYdWns4PlY0/ummCCRsXSBvZ7ypCB+VJX6DWxfVb6?=
 =?us-ascii?Q?bZfUlvHSKwezKfotpfhaJA1TaC73DIgtDIh1NiqhKXHo1Qt1WdsiD9jLvO3Y?=
 =?us-ascii?Q?/VD7n3tEdRDL2dRqTEAMTovxIvqP9V9w7raVXKQUvcf8GjM01RHkbOaIeM3D?=
 =?us-ascii?Q?xOdKRvA3LB9M2QO20wvq/je5seAU9LG/GCR1ICI1HVAINr7mJspCTS716B4e?=
 =?us-ascii?Q?xWfYfy530jsXqvuweZCTOPzDmX+agwSLMMrhbGt1Wao+fdnXQhIdS665c3VT?=
 =?us-ascii?Q?VL0M+mACw92gDVfzD64+8soBq76nRzjC4X47J4D6ilCUFC4U1e87IP2Xv1KY?=
 =?us-ascii?Q?dwrj8VHfqfTfIIAvfCyyp8n2EwTsJNLITo5yGcWV7ZwwAc1CoInaCn7vTsl5?=
 =?us-ascii?Q?3uWfpBrGimbumvnyRfeO4HjRr8w+A1jmkGX9LhAsS8rzKTNKr30FXz4NqwDT?=
 =?us-ascii?Q?E8nxajqNxR5hnzdf+KH7WUkoIqudWH58TIK6DaXuMyzhLvwn4dRnXSVDG4ta?=
 =?us-ascii?Q?D6y/dhW0k3tiABghgXI2i15fNNCqoLFZ7297pyuTpjTBI2PYtfdB0IDfyS02?=
 =?us-ascii?Q?ach6Y5PE0wMpDwsfDyiNabvF76I4VcrZNlcrnqKj+j0VA9p+He2IXWjb8rfw?=
 =?us-ascii?Q?7VxudZ7e956zRaNQVyWjxsD5V6lJ36b0uwgY2QX3XvSO8O/W6XW9vuRpqyN/?=
 =?us-ascii?Q?ObJw2NKJ2z6lbvnN/9OwWU6YSCxfFZ4Hp0TKg3Qq39hjTwfKB/jySBSX+v4u?=
 =?us-ascii?Q?DeppJ3FneftTMSKoKAezhVvOfKjN4M4El/lm87JJVYDlnUK/Vd+eMqSdxuAZ?=
 =?us-ascii?Q?kGdS/mJdBRSe0ZXVdaCpVPKnMXwCddNViaiTpxzFOtiI7BH5HPOtUzFAkLUQ?=
 =?us-ascii?Q?bQZaUWJYktQf0FHXeziX/URxWANesJUCMNw3GtwbYHarmNx/VlSibrfGxLlr?=
 =?us-ascii?Q?ADNOiI67GXhpmZB/7L+P+iixgGSi/PzTj0/D6BhZtqLx0twe9uEVaECPZUfN?=
 =?us-ascii?Q?UON34T/v/IPKIa49bYdouPbIZ7RHuJ2XmaoWQwNbXy6/G/b8t3U3grySWdx6?=
 =?us-ascii?Q?C2ngCdJyQx4/W76dA+Za7sOSStPB3sukniSxyPFEICH6LTy9OynhNsMZi7Cq?=
 =?us-ascii?Q?LboiEOWmu7FxJDiRhkbaDa8H5Oj1tl6s07IgOHicY3iYLkAiFQi85qhtBIfQ?=
 =?us-ascii?Q?wHUPeNPBzFzwrp5rqYc89+NsiPusnGW8knC/+BYG9Vc2CZxyf0q6t2n0DXWd?=
 =?us-ascii?Q?a3eRk6F07QUmGuHKIqL6/fbU8DIidfWQ8O7Wv3MIOoWHhP9Anp9jrdzty6/p?=
 =?us-ascii?Q?CdGHrs5xTnJW/3MoOS8LFcfVoKfSR0Ygi7hU2RBL?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A69696CBFFA8694B9FBF3227F37AFD19@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967736de-f3e4-49fa-92b6-08dbe0770ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 16:23:28.8180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KL7NB0g2GRQqfh6P5XMh9D1QwRXER1LrMkB7U8VQnLVBVQ9Tko3W2Gpydb66duVIlRGviasm9H4z/ahyV63y6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5947
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 11:33:37AM +0000, Christophe Leroy wrote:
> As far as I remember, Daniel's proposal had some weaknesses that were=20
> never addressed. At that time I proposed an alternative series that was=20
> addressing most weaknesses, and my series was considered more mature=20
> that Daniel's one by several maintainers. But I never got enough=20
> feedback on it in order to finalise and merge it.

It does something entirely different and doesn't solve the problems .. Cert=
ain
doesn't solve my problems.

Daniel=
