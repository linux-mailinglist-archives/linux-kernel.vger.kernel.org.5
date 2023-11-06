Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910107E1FB3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjKFLMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFLMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:12:46 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8F598;
        Mon,  6 Nov 2023 03:12:42 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A68J15p025615;
        Mon, 6 Nov 2023 03:12:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        proofpoint; bh=gzC97ptKKkxdg/bRcI+fu47ntLRWc+kVSGW8noqSOB0=; b=h
        UXzZZL+KkGRizbuiZH6BvWZtAkDAOho/JMpEk5HboF7nLxU1pz7XBFIHC7SSijiJ
        VIBIgX53tccKkxZ0rExrlOxl34pw/kUQ6FHZVp2uVvqw/u9E5KyE4fu4MT6qKL2Y
        YROTMDMWOLbIuXkvU4GFrdaIbsjMmZEePyIgrhpSODiDHpwvRB7WjBLxb0lMLuwX
        drB0UVv0dc1V3tc5JLWd6SoIr7UudwXvm6N+qSexvh/mIvdhinkwX6nBGHl77n34
        X2vL3mflm9rnX4c/Iy0dYYZueI39jwSL8QzFyJduuyeK36ms4PnYDvzC0Hx4FjcS
        rh5if8K31z5Wu4M5dDyhw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3u5jgsdh0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 03:12:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYHXUe+RpMMIf57KCnm1kfcpmva6Yq8SGTjMo2miSoISwPW0PHHgkua8QnXQgBOrIdE2woCAWzOVbF/4rSfYicJAt9lLfTsBdV1WLcgSWWHK+PgviZmPprqQu226MyCcrYL85+GmukKdaADoAz0PNdtGTthNRrUs6Yh78IwSIMDK+n+IJUwiC+2US91gVKHmtakMnD6yrC/H5EFUv4QBrXyE9cEA2L0puJSJcaiQmq/yWwWPcHpApyRnyngRD0Ge37Swy9uZdXxKRt5JMgFQQ2P+luGxluwPJMJVvp3vSQPmjDgdBEQIiVc3EdQz6/6/vX6e8sWVNI8Q88gcntmYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzC97ptKKkxdg/bRcI+fu47ntLRWc+kVSGW8noqSOB0=;
 b=aLiaMgvX3cG5nyfPK2XnBhCGnDAmY9ylSXV5Ov3fcI5dCw387q+O4MiBNMzQYSfxag0Bs4lXhTBjCcJhudxJWfqybNTvYB91LhtOpYruYzcbo6tBikuCtFw/bD02jYzG55i8RowgbC3ICNxWtegn/s8j9J47AcTY5pOlMlexNP646Yfeufydh6mkOZzBSqKAEevjjWsA2M1/XAV86ZPMk13/owmALjOK93rCRcc+kFMSBKHHFiiASSNz4hMz2ibyUPwQxLORRwXj6B43FAo3yBtQvmEw2MzIWfLVkKFuMOeGc77nnHbm13bgbHjJaanZYGBnQlXkqdga/O0fZUJDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzC97ptKKkxdg/bRcI+fu47ntLRWc+kVSGW8noqSOB0=;
 b=oqmUzcWoafDMKkGtfyZzXMVuiCmCyyh01pW0qfUmsQzf5pasXUB1ilyxhZhohNCA3ZVlY4IWpMQgSswA4OgLBu6KFcrnyIUIpeMbcLLn3WL4WQtIioYEHRbIjpKoPho8HT0FlBdMaWuTxBm4dtpUamKu49bHx5oad++coXJNWR8=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by PH0PR07MB8479.namprd07.prod.outlook.com (2603:10b6:510:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 11:12:11 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::349b:3cfa:d8e3:df26]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::349b:3cfa:d8e3:df26%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 11:12:10 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Frank Li <Frank.li@nxp.com>
CC:     "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: cdns3 uvc first ISO parkage lost problem
Thread-Topic: cdns3 uvc first ISO parkage lost problem
Thread-Index: AQHaCPA13WAOp4MeAkqlygNsWSmHvrBh2GoQgACv/wCAAPw/UA==
Date:   Mon, 6 Nov 2023 11:12:10 +0000
Message-ID: <BYAPR07MB538112FE4150BC19696D7613DDAAA@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <ZTvhEl+JcnhJXcrl@lizhi-Precision-Tower-5810>
 <BYAPR07MB5381F7224612F0C0793B6B29DDA1A@BYAPR07MB5381.namprd07.prod.outlook.com>
 <ZT/XkhOvbucxA90V@lizhi-Precision-Tower-5810>
In-Reply-To: <ZT/XkhOvbucxA90V@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNTI5YWFmNTEtN2M5NS0xMWVlLWE4ODQtMDBiZTQzMTQxNTFlXGFtZS10ZXN0XDUyOWFhZjUyLTdjOTUtMTFlZS1hODg0LTAwYmU0MzE0MTUxZWJvZHkudHh0IiBzej0iMTE3NTIiIHQ9IjEzMzQzNzQyNzI4MzMyNTA0MyIgaD0iVm9pa2x0MnlreXNhU0FxVWdLK3ZNU3dIZUJNPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|PH0PR07MB8479:EE_
x-ms-office365-filtering-correlation-id: 05023d8c-8cff-4264-e800-08dbdeb93888
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RkNqTMIrd1bhQxXb7g/6hUN1lTqFX1WZB5igVohnuaKGeYnFh8NeocSWL3aC0+avtfmfPeNUyPZo9TwseMJfDmtOG8jgupJBss9aUiE/PraEg3Hsjth9A0HsB3d5CGStsI0IP7EK/7fL/yXeK7+qM0yGhC4olCr1Vaz/Nav5E5D0GdXiL7k0WkWwfPz4Oe2myx/RqHdtvw4wDqPIIv//dnWf243UYEbQMJwzM84+ptO29GCd4cCL9OMYTTfenydUf9on6wIA/5AcZsPCOEgAwpkT86i6xaNsn6b3ETH5/hS074mIe+CF2JiB6Qyoy1PDV+lIINpqwgRQj4hGmd356o2xn5MfpLcsMwLrVWSkDVSHNxnTJBLE9RdQ1iuZXjf/mCG2UVhiPO25Iln6BZgF98H/U37Wr8WXg/tzrOEBEqhotlRngCbHaf2G7wXsobnah7Brmj9LaY5lF42UFS/qVwysuyZ5dku/FjvlaTpLCdpGY9cJtcyDEaQPOFVc6ACMsDizc/wzSvskD1v8ksGFJDyTyFhTaKbfbksqtvGex05U6xq61J92IHfPOsSCwR7YPec0vDPjgLz08xNJsy77bfjkvvHOsEwuqZBTglQpvdQpKCE9FKpzVlu87f8eI6jtCX24kc5uwzeizPjnm4z9NQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(26005)(66556008)(66946007)(54906003)(66476007)(66446008)(64756008)(6916009)(316002)(76116006)(71200400001)(7696005)(6506007)(9686003)(38070700009)(38100700002)(122000001)(83380400001)(33656002)(86362001)(966005)(4326008)(478600001)(2906002)(8676002)(8936002)(52536014)(5660300002)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IG5XjEqh9jIL/2ClFiXyPqX3Rn6DqWxzmtQI/7hhFN1I7iKbPzU/x8NadJL2?=
 =?us-ascii?Q?Drbs8jjv0SucAnoiekFTMvkDzjtn3PZPWR0O9Y5zQyXq35CSELscxOolFLNO?=
 =?us-ascii?Q?EUjHd9rSr+YTPS+y5FZ9/+Px62A7N/K1L43Hj3OAuYS3RdVXNKlpojth7nPx?=
 =?us-ascii?Q?RmdGej7qXF14nvAh30MiHpCI722VehaCYC+dAoDiawpAPghJpZrtn7Ls0uN8?=
 =?us-ascii?Q?nRNiUxBWg+rKJ5wjsjEDrDLnpcpZbgcxS2W44ATe+EHsy8/Q9DBIeWJ7/9lN?=
 =?us-ascii?Q?3IVQj7abzwOOaiHlfa4uEsDNnWOpDzCGZoRHoagudT2JFgzO7jSzqQreHBjH?=
 =?us-ascii?Q?HD10NPUDuXPReOQK73tuy48z398kI7jiAE0/0o9XlIWor1xudh9VUNC8OxDD?=
 =?us-ascii?Q?pyQwUaaa7F2++DODkQgF8rCg/NTeRi96jbH5sMMWzDEgVeU68pQJVRNw6IrS?=
 =?us-ascii?Q?3FyRdIELW70psHIOLHF5rK01Mvd5S28RrcYFYXoW7e1Hnf2YjZUZOnZ8rx+Y?=
 =?us-ascii?Q?An5QNYHWPfvHflSW249PdvU2PffxMRarBPeVp0nmZpTOYa/cjGqk/k0KjPtL?=
 =?us-ascii?Q?5BST1eyVyyB3f++PEEmeEsR1ZEEpg3hnpYvvipaICx/IrPeD9M0jIE3FOhoT?=
 =?us-ascii?Q?2jFtlNfKZmbP6WiZfeehfL8BY7FObhiVwWT4NuWdw4KoMbxZ1Ykr49soaZay?=
 =?us-ascii?Q?PHmS8IKN9/eHCIXs7Jl7lYB5Gx1SPHYjuBuVF/00xnodr7irUje5BAyny+Vk?=
 =?us-ascii?Q?6vVgrTEDv8u9Vw55mswIzhHJoj97Pi9PW4WxnhESuhMLDvGIe0t+Mq4MRbKU?=
 =?us-ascii?Q?yO+vn+pQOLxBwRBAEpGjSFic3dFFYSLBQhb0h8xS3SMtow2Aooaz8PFey3Iz?=
 =?us-ascii?Q?ZGQKGLLsfxkrTVomaviHzTCtUkCosHrjKqgkboUyq3eSscc/QVNFvghMJNJC?=
 =?us-ascii?Q?9oDJ3BvUHONE4tYIL7y87gAJgvGccJl+cTSiCQMkTBrdZLWsye/cI7+vl3rN?=
 =?us-ascii?Q?BFPTVfcS3YYG092UsWXClMWODWI2FqQsoQSFmqhvs55dtVAqGH0FIUlk1VdQ?=
 =?us-ascii?Q?P2TlzhkpjsfoWuPHPBqf0xqruZL/a/zVr5J9hWN7cbaUH+B8t2slm30iCflS?=
 =?us-ascii?Q?2USld5TzvevX3rt/D1Sksg9zCPpSRuilgbFrZmtcX3qfbp2zeFS38k0sgTIf?=
 =?us-ascii?Q?pDXtexXRrlF+BxnfvwsUDEEgKjgBvUpHJ5IgeChQ1jAz/FaQy4mEW2D7dipr?=
 =?us-ascii?Q?Ei9FGldSw2ZEQV2PbLCDpezsGxo9yw7bDEYiAr45wpNZmamClvXRaDB2bxJ9?=
 =?us-ascii?Q?tn8tXAewmPsz2bbmeq69LJucZa67nVyiHWfIBH0edFf2VG5swqbuijwPDLXd?=
 =?us-ascii?Q?NROw7ekwMK3D60FiD+xeQ4jTibry8pD19yVyVadsdsljLDAaOl8gscPuN9F1?=
 =?us-ascii?Q?F2PyO3695OIUK1rUHf6fYD0QfBob8ntRWRWYxNTVptOtpKsgucHzTdJV+guK?=
 =?us-ascii?Q?pnWl+l06YBUHQlNUOHFqSrj8BBcr6emAARWclMRSpJNyh38vq4YlU2jEBtcQ?=
 =?us-ascii?Q?f34nwA43CsRvzEoT5u0ZSEM69D9MSDxIY8L4OJ7X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05023d8c-8cff-4264-e800-08dbdeb93888
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 11:12:10.1413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0sypKjUlq/wVD8GfMH1VVrSkphXadrus8/lF5JRKawZoRrsn+cslbnELSh1mhZjzvROvt/4QzkehIQCx5s7NAmdPZt/cQx4KTj2Z3TcF9Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB8479
X-Proofpoint-ORIG-GUID: pL9aqCto9-MEuOvb6gVPF79nSC5neFQj
X-Proofpoint-GUID: pL9aqCto9-MEuOvb6gVPF79nSC5neFQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_09,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=293 malwarescore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2310240000 definitions=main-2311060093
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Mon, Oct 30, 2023 at 06:34:48AM +0000, Pawel Laszczak wrote:
>>
>> >
>> >hi Pawel Laszczak
>> >
>> >Recently, I met the problem when use uvc. UVC report jpg header error.
>> >
>> >Basic reproduce steps.
>> >Gadget side:
>> >1 -
>> >	https://urldefense.com/v3/__https://gist.github.com/kbingham/c39c
>>
>>4cc7c20882a104c08df5206e2f9f?permalink_comment_id=3D3270713__;!!EHsc
>m
>>
>>S1ygiU1lA!H1h8GlLnbS6vqklXm_2qGyinP638O62Kk2eLB9zeMkjAGXUAPYyPXD
>L
>> >FasSqYt16xq0RGT0Ff-cP4A$
>> >	uvc-gadget.sh start
>> >2 -
>> >	https://urldefense.com/v3/__https://git.ideasonboard.org/uvc-
>>
>>gadget.git__;!!EHscmS1ygiU1lA!H1h8GlLnbS6vqklXm_2qGyinP638O62Kk2eLB
>9z
>> >eMkjAGXUAPYyPXDLFasSqYt16xq0RGT1ogOdRQA$
>> >	uvc-gadget -i test.jpg
>> >
>> >
>> >Host side:
>> >	https://urldefense.com/v3/__https://github.com/thekvs/uvccapture2
>>
>>__;!!EHscmS1ygiU1lA!H1h8GlLnbS6vqklXm_2qGyinP638O62Kk2eLB9zeMkjAG
>X
>> >UAPYyPXDLFasSqYt16xq0RGT1MNlKiXA$
>> >	uvccapture2 --device /dev/video0  --resolution 640x360 --count 1 --
>> >result 8qxp.jpeg
>> >
>> >	It will report jpeg header error.
>> >
>> >
>> >After debugs, I found two problem.
>> >
>> >Problem 1, sg is enabled. so uvc driver will use sg. each package
>> >include two trb,  trb0 is 8bytes header, trb1 is 1016bytes. total 1024.
>> >
>> >num_trb here is wrong.
>> >it should be
>> >	num_trb =3D priv_ep->interval * request->num_mapped_sgs.
>> >
>> >because priv_ep->interval is 1, I just simple set to
>> >request->num_mapped_sg as below patch. USB analyer show one whole
>> >1024 ISO package sent out as expectation although document said only
>> >support one TD when use ISO (Maybe my doc is too old).
>>
>> Support for sg  in uvc has been added after upstreaming this driver,
>> so the driver needs some improvement.
>>
>> Calculating of num_trb probably will more complicated change.
>>
>> You can see how it is implemented in
>>
>https://urldefense.com/v3/__https://elixir.bootlin.com/linux/latest/source=
/d
>rivers/usb/gadget/udc/cdns2/cdns2-
>gadget.c*L412__;Iw!!EHscmS1ygiU1lA!EZS2StTKnSzdCT7N5B1-
>l8nGXQgS63KwgcGINcpBC8rnRJu2u8ryV1UjwQb6YfwYLPq9T_115KC5qQ$ .
>>
>> CDNS2 is different controller and support only HS but has borrowed the
>DMA part from CDNS3.
>> It was upsteamed after adding sg to UVC.
>>
>> Regarding TD, it is true that controller can support only one TD per
>> SOF but this TD can contain many TRBs
>
>Okay, great. I can work a patch if I can resolve problem 2.

At this moment I don't know how to resolve the problem 2.
I'm going to recreate this case on my side and try to find some solution.

Pawel=20

>
>>
>> >
>> >diff --git a/drivers/usb/cdns3/cdns3-gadget.c
>> >b/drivers/usb/cdns3/cdns3- gadget.c index
>> >69a44bd7e5d02..8cc99a885883f 100644
>> >--- a/drivers/usb/cdns3/cdns3-gadget.c
>> >+++ b/drivers/usb/cdns3/cdns3-gadget.c
>> >@@ -1125,10 +1125,7 @@ static int cdns3_ep_run_transfer(struct
>> >cdns3_endpoint *priv_ep,
>> >        struct scatterlist *s =3D NULL;
>> >        bool sg_supported =3D !!(request->num_mapped_sgs);
>> >
>> >-       if (priv_ep->type =3D=3D USB_ENDPOINT_XFER_ISOC)
>> >-               num_trb =3D priv_ep->interval;
>> >-       else
>> >-               num_trb =3D sg_supported ? request->num_mapped_sgs : 1;
>> >+       num_trb =3D sg_supported ? request->num_mapped_sgs : 1;
>> >
>> >        if (num_trb > priv_ep->free_trbs) {
>> >                priv_ep->flags |=3D EP_RING_FULL;
>> >
>> >
>> >*** Problem 2 ***
>> >
>> >According to doc and my observation, looks like hardware fetch data
>> >into FIFO when get SOF, then transfer data when get IN token. Each
>> >SOF will increase TRB regardless it is ready or not.
>>
>> Yes, but this fetched data will be sent in next  ITP.
>>
>> >
>> >When gadget complete equeue ISO data, so SOF will increase TRB
>> >regardless if there are IN token.
>> >
>> >   SOF       SOF       SOF     SOF  IN    SOF ....
>> >      TRB0      TRB1      TRB2      TRB3  ...
>> >
>> >
>> >Host may start get data at some time after gadget queue data.
>> >
>> >So TRB0..2 data will be lost.
>> >
>> >If it is audio data, it should be okay. But for uvc, it is jpeg
>> >header, so host side report error.
>> >
>> >I checked dwc gadget driver, which start equeue ISO data only get NYET.
>> >
>> >I check cdns spec, there are ISOERR. But it is never happen.
>> >According to document, ISOERR should issue when IN token and FIFO no
>data.
>> >
>>
>> Current CDNS3 driver has disabled ISOERR. Did you enable it?
>
>Yes, I enabled all IRQ.
>
>+       if (priv_ep->type =3D=3D USB_ENDPOINT_XFER_ISOC && priv_ep->dir) {
>+               priv_ep->flags |=3D EP_QUIRK_ISO_IN_NOST;
>+               reg |=3D 0xFFFF;
>+       }
>
>Supposed ISOERR should happen even DMA is disabled.
>But I also tried enable DMA, and using lenght 0 TRB and link to loop.
>
>Still no ISOERR happen. I can see TRBADDR changed, but still no ISOERR
>
>
> irq/447-5b13000-200     [000] d..1.    78.662729: cdns3_epx_irq: IRQ for =
ep2in:
>00000804 IOC , ep_traddr: c0086018 ep_last_sid: 00000000 use_streams: 0
>
>	 ^^^^^^^
> irq/447-5b13000-200     [000] d..1.    78.662851: cdns3_epx_irq: IRQ for =
ep2in:
>00000804 IOC , ep_traddr: c008600c ep_last_sid: 00000000 use_streams: 0
> irq/447-5b13000-200     [000] d..1.    78.662975: cdns3_epx_irq: IRQ for =
ep2in:
>00000804 IOC , ep_traddr: c0086018 ep_last_sid: 00000000 use_streams: 0
>
>STS is 0x804, only IOC set.
>
>Frank
>
>>
>> >I tried below method
>> >	1.  Delay queue TRB, but no ISOERR.
>> >	2.  queue a lenght 0 TRB,but no ISOERR
>> >
>> >My question is how to delay queue TRB to ISO IN token really happen
>> >to avoid lost JPEG header.
>> >
>> >Frank
>> >
>> >
>> >
>> >
>> >
>>
