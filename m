Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3D7CCA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbjJQSYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjJQSYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:24:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F0F93;
        Tue, 17 Oct 2023 11:24:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HHsCc5013751;
        Tue, 17 Oct 2023 18:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6qTKwR3Lu400fYbX5vD0N0lJgSl03gwZGfe/2FR7bYc=;
 b=z4u5Y3DRF4plS8K3aqplcJECtr35bS7X6BSJigD0wCMMR78xfKkdkxp/1elDt0HbLpaT
 wqGbJifJoOy/FLIm7AQdgPllc6Y3ZM571QQ+dGOsVblwEB00pizAOAxP5OL22bwJkDsK
 dvpWqIUqFg+33RS4S1Mon0mXVxDj5Vfom2OPqZePz0GkfsjjqWy2wSIiJXWsIHvmotrP
 eDoDsw1KqSpLnpSU3W4bnwWqGcukDkWs+FADqiLB759w/hozRDSFMgqy0JNvDnpwY1/9
 Z48OClJ3rIEJDP5zmyvwnC6q3Jj0zkhjqH6YjpwYM668ux/yU5gMYl5txq9XRbsYLsF+ gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1duy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 18:24:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39HGuWLQ027152;
        Tue, 17 Oct 2023 18:24:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg54815s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 18:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGbuNwgk7SgIbz7MrpWH7mhnazxo9ojn/53+Cm2YHEa2ae2jARHadm2/DIeZY5NoQ/+lVPLLykIpAZT4nygb4LnOFsZcAB3+H/IM9A13Qoh0iZ2n6fd0VLJ3Akdd8kAjM93AGDNfa9MtRw/2vgY0u7xOpxVinkravWIuRrVw5IfFBZpMSL/DCJpqVaYKWMUXTu2CHN1wAANhOwh15uWYUiaDbg+GeIVsH2hBGRVIvIEf1GcnpZM7iwG79n5LvI2RuA/d3bnxBYH5ogUnNfnNTNtQMwF0bAuQMRUeQyuE5okc44rEm8Seh+i78Mkyeabw6fLh0ooC/z69zu22pUnPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qTKwR3Lu400fYbX5vD0N0lJgSl03gwZGfe/2FR7bYc=;
 b=dWu7Oo76pNWsnjrh1dTQSvUWdB2qrsGhVLLObLjd1Xi/dU0hjgqFPyedKNVwcb2GPAIbmyMSFdlqFtlFD1UHuK1+ZmEUsumyBXKjYMFek1tUggvWWU0DhbCYVhycSVNp+i+dFBpC+Aba8OqFD18SL0144dqKGdzW8honPlgb27pm5BStXRkC1wdVJuemI79HezmAu+dqfJbEqwyy91zSJ/FATQ0n3+Y9Y2LzwbFaQZCWeXeb9MJtliJGf+GNGQbsbOkkcKQ0TT67dYOolDFVfbJnOlaaBJSOWRXCkako89uzTre766Zem/rsc5+xt6eVD8MnUOu8D/+snyUw7YAKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qTKwR3Lu400fYbX5vD0N0lJgSl03gwZGfe/2FR7bYc=;
 b=TsoFCscu6DsFjIaRy9UrNfDae0G5wCaQzu9BcuofqP35Y7dv50IcT6CuY4BbI8E4pjZU65uZgS+RmxSz/UlfuWNEBjinri0/yW+tDqtu1RW9jdFbc2bGwbE4Aor49gF1nTI8NBTw2yDKOHnW/fj2c2bGJkXVOkJmf+TFKfdFZ74=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by DS7PR10MB5007.namprd10.prod.outlook.com (2603:10b6:5:3ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 18:24:07 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91%6]) with mapi id 15.20.6863.032; Tue, 17 Oct 2023
 18:24:07 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Oliver Sang <oliver.sang@intel.com>
CC:     Jakub Kicinski <kuba@kernel.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [linus:master] [connector/cn_proc]  2aa1f7a1f4:
 BUG:kernel_NULL_pointer_dereference,address
Thread-Topic: [linus:master] [connector/cn_proc]  2aa1f7a1f4:
 BUG:kernel_NULL_pointer_dereference,address
Thread-Index: AQHZ647wLdBfKiOcokm+jxdng1npYrA52wCAgA6f94CABUB2AIAAu6IA
Date:   Tue, 17 Oct 2023 18:24:06 +0000
Message-ID: <8E4806C7-0850-4719-8C1D-95F498562B03@oracle.com>
References: <202309201456.84c19e27-oliver.sang@intel.com>
 <20231004084011.7aeef442@kernel.org>
 <E79EF019-0E7F-4935-87AB-6A543A134E35@oracle.com>
 <ZS4z1mxtTIEpFZI/@xsang-OptiPlex-9020>
In-Reply-To: <ZS4z1mxtTIEpFZI/@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|DS7PR10MB5007:EE_
x-ms-office365-filtering-correlation-id: a8ea1e2a-e0fc-40d7-ef23-08dbcf3e3fdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jWoi3zLEKJoLZrUlFv8HoMGekGLHI4ZMg9QZpDckb0++lYshs7Aj9Zti/xe7Mu62j56sducNy0y+CkAnFPJkFzgUdP8iCQBlke0/f1rmJdyCPZ1Ab5WsVMe8vZOEyVvPB1e1Vn27gtfTfB801vIqWUpCChFhgalqOGr3g5JhCfcE7GL1kl2qs4TQACtZwbjW4w1xcvrsQM4iGQhDtAEkIP8qXlTFCT2+c2k7JxVbG9k+zU2ExYOWVD8syBFbw/jm1KuhEq5UNw+tGct1JCYs3tE3+mU3Qtx8XmklKBNUFQh1gaFVp6VU6iET0ccUeSfZ7dB4FvAb/7KQD7jx9m8+iIOt4KE6L1j1L3YUQ4E4GtzPZzoXcycAIy4ZY5lg8s5SfcupoM0Pljy05hiZCOz9GALUZTx67YZvmajjCz8FpjoAlJaIDr6MAG9aNQ1PbeO0V6pAtCEEWF8AHPEBAy2wlS9gOKT2g3AdJsLOvpADt9HKKRsrJvJC6O6TKVbCs9eKZq1ISR6y7cJGoiIjniyXn0Mv1l1WLHhG6DVsJNZNVfhbIKJqt2xDd1Rc/cFwusHzgmoVYONkJkPxYMae74hOUgY/dLBCQn2VLJNF90QZhYBigMLp3dVrOzgIQxIykXbIMTG3hWWWwb+j+1WCaD9dfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(966005)(54906003)(64756008)(66946007)(6916009)(478600001)(6486002)(76116006)(66556008)(71200400001)(66446008)(66476007)(91956017)(316002)(83380400001)(38100700002)(6512007)(2616005)(53546011)(6506007)(26005)(36756003)(86362001)(33656002)(41300700001)(38070700005)(122000001)(5660300002)(4326008)(2906002)(8936002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE5PMFpPUkdLbVp2SFBNMGoxMkhad1lPY281OGd0cjd1OWZKbGlReFNCSjZz?=
 =?utf-8?B?Z0dFSGNoclpYVUwwL0ZUK3lTNTFDQ3hDQjVoUHErbVd3ODZEZkI1ZzRzamRs?=
 =?utf-8?B?NFdZK2szNDRrUlRzd2RJRExEbkZvUGg5d1BoRml1dDJ2WTZMazdLejk3aG1N?=
 =?utf-8?B?ejQwNmUybWpCemVURllmaXBlVmduZ040cTBEYkxQM1F5Zk9CY3BGK3dWZis5?=
 =?utf-8?B?OWFNUEVDNDJJdnBCSUppSVFBS2hpYStGZXZuWXdUblIvcXRsNmVoelZSVENV?=
 =?utf-8?B?d3NINXViczNleDhHMWZDckN2dnp3WGQ3eklKUXZVVG9qdEx0TytkMkQwb2FX?=
 =?utf-8?B?OVY4SUQ1aHc0WU1MY3E5VVdVcjhKd1B3ZVFFeXIzZSs1VzRNd055TVRJMzZ1?=
 =?utf-8?B?ZFROZXdoUVgrbzQ3cm92TTBuOTU5RVNYWW5oWFVuVWJMVGEzbS9Mdk5CRTE3?=
 =?utf-8?B?UVFhZ0djYW1pMWlpN3Q2YXJFdWdKVTh3bWtWOWFHd3FaVVprcFJCVTRBNmJZ?=
 =?utf-8?B?WUtvRHc3dllFcWUwZHFJVTlQOU9tV3cxMlJKZUFzbWZVems5MUx3aDFsZTlK?=
 =?utf-8?B?WHpocFpNQm5UUGhNclpXTzVzOHRMSS81dTZTV2RBaGIrNElVRWttNWdHVnhk?=
 =?utf-8?B?a3dCTFhVS3RKYm9hUGpWUGdrVlJqaG9TOWZSeWlqUW93SFBqcGNLclFQeWdX?=
 =?utf-8?B?YmViTnpadUdsb0crWXQ5ZTE3ZWtjU2RUaG9RL3hHNTFsb3VLblVDaEJLTGpa?=
 =?utf-8?B?TzliTGlqMzJGcUlhT3ZnejhJSFNybWtvZlEvQWhKNHJuNzV3MDFVZTljeXFl?=
 =?utf-8?B?b2tHT1ZSL25tbzdCOXBmOVNPSkh3dzcvRFZEcm5IckVZQzNnNDJnL3F4ZVV6?=
 =?utf-8?B?K2hrOGlHODM2and2bWxJQVNlNkVlWFg0dDBqeGlVdmd1YjJrVFFueG9jc2tq?=
 =?utf-8?B?bXBjcU10a3NjYVJDSnRYbzBscEJrVC9xYkFIRnppM29VZEZydWRaeXhGM0Zs?=
 =?utf-8?B?b09TS01rRkdXMWc3UmJQS3FkUkhSZi9ETWVqSnRNWVdscWlFbkJ2b0JRbysz?=
 =?utf-8?B?b05BUCtzekVtblM1MG5sazZhSHA1OWpCZkVmM25qYTFzdkVvYlNacFFGQmQ2?=
 =?utf-8?B?V2tDcU8rU0gyQnlPbFdQVlRYYVNwdkw5eHFxTzMxcHBXdEJ6SHJRNys0ckVx?=
 =?utf-8?B?QW16ZXBmOG1UaFhqVFluS2NudURzYjlvQjFzdnFVTXUrZUF1QVVDOGtpRGVl?=
 =?utf-8?B?bmc4anZUY05BN29abU1sTW5mczdJckJYMlhNZ092R1I0Y2JLcFdia09sU21T?=
 =?utf-8?B?ckdZcHJYU2x2S3ZrMk9PQUpoVVM1eDJqVk1ZSjE3dnEya1dDUlZoWjFuL2xx?=
 =?utf-8?B?Rkd3SldDU0pHRWtMYUp5ckdWalNXdW5sa0dWRDNDRnJzZFJIVVRZSFJSU2RE?=
 =?utf-8?B?QVRBM0JTZ3F3SjlJM1JSUkVUdUhiYTJrYVZlL21NR3JQTTVlSDZaQzVpRzdl?=
 =?utf-8?B?d3MxUW9XeWVrNWQ5bGVJM0lkMWVabC81eFdjRjBIdG1YWVd6Ny8xL2R3Y3dE?=
 =?utf-8?B?eGlhQUU1L0tQRXhkc0ZjL2UvVHZ4cnpjc3Awci9EbGNrMWJKTEIvenNLTFhV?=
 =?utf-8?B?aENkYmx4TnF2S1d6ZVgyb2dXb0Q1ZzN2alVtTHZNNHBsUmoyYzNRTjlGMFV3?=
 =?utf-8?B?T29YeVJpdXE4OTVNTlVYZXBvcDNsUW1tc1AyS3pvZkJHOUEwR2oxRkpyQzY2?=
 =?utf-8?B?WXE5OTExcU5RSEpxVmIybVJVRjM3RTNFTVlnNmNiUWdGbXV4Wnh6ckI5SCtn?=
 =?utf-8?B?bXpQVFhXbURBTmYyTGh4UFNiTWxxanFlazB6eGk5SEJ6ay9zK1EzSlF3dnZR?=
 =?utf-8?B?ZUxGemJBeldNbnhGRmhhcThXak5NeVNwbFV1NldHVFlpZ3owTXBqV0NPUThh?=
 =?utf-8?B?WlNjbzQ0cWt0VHlHcnJIL0kyMkZWZnBwdm1oa3BRcXRQcjZ4dDFGbWkwMGVh?=
 =?utf-8?B?eU16a3Bmay9hSkx5ZmgrVGdRK2VUWnQ4VCswazJXR3doNHUrOTBiSXIwMDN6?=
 =?utf-8?B?Y1VIMVBibHhaejJ5b1hDQzJwQ0RxRmxuTVllSGJmSXJnUmtxMWZPcmVHNVd1?=
 =?utf-8?B?MWVFL2lGOFhHaWFWbDFrWmJYRGRqVTA5M0ExYWJsV1NpT1hORG9nWjFXbUFa?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57D00E4B715DF24E9896FEFA30D0107E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iBjnD85KJIVFUwAw+cx4cJhtdcukf1Ykf5u4H5ZUGPv034pzbxilrgg89YUx38sJpMs9cc1kmNGrlvkDvC8zK1locyp8E+8hf2l4jmYxV6Jjm5F/1xHTVBwM3xyhiLq5EoLc+ld7wrqgcQnl+KZi3GufPslvmzM+YQAAsMM3dVOuAyspvuaxJiQKGEl0l4Dam4L0tpHpXhtc/Ynme1DYWd9Ov4E0qT12UQHJhQjDHsBumTXeM8Wp9hZ/0bdBRUoMWATHC0wRC9ypJsbK9gCVE//0CtdwHliTljTSu6ykv09r0vWPlbdtmpyLuTRaJ0u9umWDoFFkHoAoQ8JlVl4TQocd1DZxEj2VZJe3qS/iaUUSIeXlFxLUlqXZn78YnpJOGuhufrC8xOSj7mZq1bFWR82vvYfEEVP6bmBQ+Ot1bFEeTvj/6Qs8qWmioWFlP8bDUlhC5RXz9MEWh95vbQd+px9Px97pWXedPiwtIbsbLAXzvzg6vNHR0L+8UZKRO3hrFUZ0Nd5B280dOBOQzHc8cCsnMnHMWKZtSQ/3HtMHyVsS/tQdb8u6bKojb2RJ1ye6O8ACplkTa1pvSBeQkmMSSkec7dCyuM09FHDUnYWEt7NxnNM561qXSwSuCtEr9PdHpNkVK6JcdNRkUohD6P72mq6xPNdJU7mzCzHEGcVMthOtsnfSPHODKE4dD/Fn2nised4L3EDPtZAWdWvrODL69VkyckOhVXUPahiEJMYiJBACBBUnI4ySqFHFCAYgv/K/2MZ5cokbS6aqkXAaRWjTpy53qHMGM0QVF6ScRa5NfBn1L0l2tHBzA5uF6DP+/jzcsvtdgRZg3dxsKaRlJ6q1CqbMr8Mgf9h03okl2pSfpdv1wQX0+GE4CCAYhViAf0w8HmxVHgFMzDWz8ROqRzpc8g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ea1e2a-e0fc-40d7-ef23-08dbcf3e3fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 18:24:06.9598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wA+5G2e3cwzzpDfZEMGa4yVMC8UFYctiUGaNqtN+6Pk9sbVd6brnOkDiQUkGfw37OVBy0tD0kSVHwbOEaUcim+a4MHTIhQzWQcw69OcdmjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5007
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170156
X-Proofpoint-GUID: TD2QAlh8IZhBIYTWL2DQIqrrMs5GVE7y
X-Proofpoint-ORIG-GUID: TD2QAlh8IZhBIYTWL2DQIqrrMs5GVE7y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDE3LCAyMDIzLCBhdCAxMjoxMiBBTSwgT2xpdmVyIFNhbmcgPG9saXZlci5z
YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBoaSwgQW5qYWxpIEt1bGthcm5pLA0KPiANCj4g
T24gRnJpLCBPY3QgMTMsIDIwMjMgYXQgMTE6MDA6MzFQTSArMDAwMCwgQW5qYWxpIEt1bGthcm5p
IHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiBPY3QgNCwgMjAyMywgYXQgODo0MCBBTSwgSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gV2VkLCAyMCBT
ZXAgMjAyMyAxNDo1MTozMiArMDgwMCBrZXJuZWwgdGVzdCByb2JvdCB3cm90ZToNCj4+Pj4ga2Vy
bmVsIHRlc3Qgcm9ib3Qgbm90aWNlZCAiQlVHOmtlcm5lbF9OVUxMX3BvaW50ZXJfZGVyZWZlcmVu
Y2UsYWRkcmVzcyIgb246DQo+Pj4+IA0KPj4+PiBjb21taXQ6IDJhYTFmN2ExZjQ3Y2U4ZGFjNzU5
M2FmNjA1YWFhODU5YjNjZjNiYjEgKCJjb25uZWN0b3IvY25fcHJvYzogQWRkIGZpbHRlcmluZyB0
byBmaXggc29tZSBidWdzIikNCj4+Pj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9jZ2l0L2xpbnV4
L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0IG1hc3Rlcg0KPj4+IA0KPj4+IEFuamFsaSwg
aGF2ZSB5b3UgaGFkIHRoZSBjaGFuY2UgdG8gbG9vayBpbnRvIHRoaXM/DQo+PiANCj4+IEhpLA0K
Pj4gSSB3YXMgdW5hYmxlIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWVzIHdpdGggdGhlIHN0ZXBzIGdp
dmVuIC0gbWFueSBwYWNrYWdlcyBhcmUgbWlzc2luZywgZXRjLiAtIEkgYW0gc3RpbGwgdHJ5aW5n
IHRob3VnaCAtIGhvd2V2ZXIsIHRoZSBzdGFjayB0cmFjZSBvZiB0aGlzIGlzc3VlIHNob3dzIGl0
IGlzIGEgTlVMTCBwb2ludGVyIGRlLXJlZmVyZW5jZSAoaXQgbG9va3MgbGlrZSBpbiBjbl9maWx0
ZXIoKSBmdW5jdGlvbikgLSBhbmQgSSBmb3VuZCBhIHBvdGVudGlhbCBzdXNwZWN0IHdoZXJlIGEg
Y2hlY2sgZm9yIE5VTEwgcG9pbnRlciB3YXMgbWlzc2luZy4gU28gSeKAmXZlIHNlbnQgb3V0IHRo
ZSBwYXRjaCBmaXggZm9yIHRoaXMgLSBpcyBpdCBwb3NzaWJsZSBmb3Igc29tZW9uZSB0byBwbGVh
c2UgdGVzdCB3aXRoIHRoaXMgZml4IGFuZCBsZXQgbWUga25vdyBpZiB0aGUgaXNzdWUgaXMgcmVz
b2x2ZWQ/IFRoZSBmaXggbG9va3MgbGlrZToNCj4gDQo+IEkgYXBwbGllZCBiZWxvdyBwYXRjaCB1
cG9uIHY2LjYtcmM2LCB0aGUgaXNzdWUgcmVwb3J0ZWQgYnkgb3JpZ2luYWwgcmVwb3J0IHdhcw0K
PiBnb25lLg0KPiANCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdGVzdGluZyEgDQoNCj4gKGFu
ZCBJIGNvbmZpcm1lZCB0aGUgaXNzdWUgc3RpbGwgY2FuIGJlIHJlcHJvZHVjZWQgb24gdjYuNi1y
YzYpDQo+IA0KPiBUZXN0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRl
bC5jb20+DQo+IA0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jb25uZWN0b3IvY25fcHJv
Yy5jIGIvZHJpdmVycy9jb25uZWN0b3IvY25fcHJvYy5jDQo+PiBpbmRleCAwNWQ1NjJlOWM4YjEu
LmE4ZTU1NTY5ZTRmNSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY29ubmVjdG9yL2NuX3Byb2Mu
Yw0KPj4gKysrIGIvZHJpdmVycy9jb25uZWN0b3IvY25fcHJvYy5jDQo+PiBAQCAtNTQsNyArNTQs
NyBAQCBzdGF0aWMgaW50IGNuX2ZpbHRlcihzdHJ1Y3Qgc29jayAqZHNrLCBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiLCB2b2lkICpkYXRhKQ0KPj4gICAgICAgIGVudW0gcHJvY19jbl9tY2FzdF9vcCBtY19v
cDsNCj4+ICAgICAgICB1aW50cHRyX3QgdmFsOw0KPj4gDQo+PiAtICAgICAgIGlmICghZHNrIHx8
ICFkYXRhKQ0KPj4gKyAgICAgICBpZiAoIWRzayB8fCAhZGF0YSB8fCAhZHNrLT5za191c2VyX2Rh
dGEpDQo+PiAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+IA0KPj4gICAgICAgIHB0ciA9IChf
X3UzMiAqKWRhdGE7DQo+PiAtLSAgMi40Mi4wDQoNCg0K
