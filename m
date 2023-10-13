Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E27C8206
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjJMJ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjJMJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:28:56 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2052.outbound.protection.outlook.com [40.92.52.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2DFB7;
        Fri, 13 Oct 2023 02:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0s5sx4D7+tPxLEdt8FFYc7H2lzKpqoiqYsHP5WfscRDjWN8DbLMEiLzMQWdU3THfxFoSyqfa8M9KgX/HKaYLEQQJgHo4KwtdRoyAbqMrJJXkpXoq0uogMR2E9gkSFLYFOUKxj4Ya2eTaA6/HUtE//xPDcuVaUKPdUiXNbER1ogDCI5hR/IBLw0Jhs2YG5i8/V4N6Mm3WxNQF4+CdtRWhLah2y+JZSvGOvRxiB7UYqE+d/sHm10ZdwbxE3whWBJ3l+kz5hQh3P1w4aW+ts8oahbn3c3hxh6dtuq2uiDxOeaXiK+7AuVINzWmhQsGfpuAXiyM/UbDhsx+B9OYattsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epj4P3t61eBt1HfJcaOuTmdBkXFR2/n4mdOlj8t/dg0=;
 b=UGQkSI0UUuWBHg96DeuPgaGGT58+ygjnt48H23PsHaZ5eew+4XpP8IFku3NsxwmlFJeh/G9gcElP600KFyG56gX7vKedOWoPe8f9jcIhVUq+dVI8pxWvmfySvNwv4rOsnUaWImlb8T6JbEXN/49xtq5eTtqF2f3e9YMALYwJiGQTcZ0jQ074PshPgPpaCn556VCad463rJpzLLwBr7RjlIRvGZn4M/lhjIPX8iPVImuuRF8jodj41K2/MU+AMXRplBy92LI3LzIHDb0WiTHlmC+Z0gwkPSb3/MbUDUJDmNJ6CWWIIPGvE/uKtXPLNpbSfkNhQOoWOUXfyX+orcP3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epj4P3t61eBt1HfJcaOuTmdBkXFR2/n4mdOlj8t/dg0=;
 b=PuEPXp+zRam7ei8LOJ2EFEnDu0kxrcy+ib1Ft8HZHH2FabUCZwy9+Md8x2yr4SBKzmOwkRwd7kKc1OeMHt9rAbH1Kol7bx33J9Y5JMgxQBGCJOocNtPyZRnOuGi9gJ9gIeYD52lYgH5XcaDHLSz6rLugR0+rkETSD+EdbjM+NufBVHGHcVzyqxl0vgnvqcr63IFO0nDTKacjYuWAZxPWtQeSqKkcKgKVmk1lpveyhkQBA0NyloHXi2fh1DMsa2tpVnmJ7QGmzhBcF//kjiCu/A8UvdZODODnGifElknrxE8Xr3ZTU+loF5+t63Pwub4aHBPM7xeMel2s7+LfSU+tWg==
Received: from PUZPR04MB6719.apcprd04.prod.outlook.com (2603:1096:301:107::15)
 by KL1PR04MB7307.apcprd04.prod.outlook.com (2603:1096:820:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 09:28:46 +0000
Received: from PUZPR04MB6719.apcprd04.prod.outlook.com
 ([fe80::6de7:2b42:e5ed:1758]) by PUZPR04MB6719.apcprd04.prod.outlook.com
 ([fe80::6de7:2b42:e5ed:1758%4]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 09:28:46 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Empowerment UN Grant;
To:     Recipients <reginasharma01@hotmail.com>
From:   GRANT <reginasharma01@hotmail.com>
Date:   Fri, 13 Oct 2023 17:28:38 +0800
Reply-To: imfgrant23@gmail.com
X-TMN:  [nH2uWuJSgfgXCeMVF9mV98VPcD29cYQB]
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To PUZPR04MB6719.apcprd04.prod.outlook.com
 (2603:1096:301:107::15)
Message-ID: <PUZPR04MB6719EB7B6197DF1182915B46DCD2A@PUZPR04MB6719.apcprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR04MB6719:EE_|KL1PR04MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: ff48bf00-d726-48bc-bcc0-08dbcbcecbd9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnVDzHfT2tHKflLUCsnxUHrfMILLQ0JpYmzffdJhEiJEoEZ4eb2+n/w8PBaNHhoNkJleIjT2kY2gtRNYfW5EOWy8Bl7rAScwjKJCEuxPglerr5p/9SSalMui1huKaNRBr9U6zzs5CwEir4PLNJMP5eO0GfEw7h8/db1i7DIADwDbuA90+lIu9MPCTasDHUzQPx67zhyfaAWmBi9SjPIWWB1cHmAXp/ZCt/XjtRlol5VPgTt2EN7SGr6iAEGzj67g99/D8HKiVt6C23BlJxz0cC+dbTk0CPQi8BkW9HSnvc40bS4WLiMSgMMG0DlntBmNF6bMDBpR+jQDy6c47qoFu4KMVJJL5sCtdiE5sjNdSsB2eoW+JswnV5BJ+bzyyBanwhgt/Jxr5we85mJP9PC6l51KqLoMvhzilAQRvndYfhFGk8PngbigVagVZft0NK1Z4ex2KKYlCtY9BxcyOuqdsSxQke5N4RRLeLFxD5/Jis+GJMPzO4iKui+2vUF+axFYzzUGBMHh7suVrZOli/vhFfqKMlKmyrMeq4DWOEJS/2duVfnWZspfnhPjtKP3qP7/PhzIEoeo2unUeWcMqiYmzzFDrRoT3A/Fcigteol8kmBQrVMo+4PmeUj+t3U6VSt2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vIQ3OA8J6Ey8aFLRtRVEZA6KiWXv+E9088XdBQI37GOv4RYBZ5SgcqorZL?=
 =?iso-8859-1?Q?U67YKIZfpNpl/5rZP8eD+JIUs4TjC/HSggQK11NLf0nAyBeRPwc+QN+HGs?=
 =?iso-8859-1?Q?8lZkW6YkELnm3FOUrKbsAelR/G+O7Mxkj/Fm2MnZjlWmZ8uH9M4PBW8JSJ?=
 =?iso-8859-1?Q?kIeuqigUkcF/rHfmF+If0hbdcl2lPVgYANr7LRaHOvH/psiHjLEB0kmXTt?=
 =?iso-8859-1?Q?M23eOnEm02qpGtix2tVE4mvGwu671h4eT+UzZPDbCsRKg5W/6sBHgzBwyJ?=
 =?iso-8859-1?Q?T6SOtU2AFHdIakhqvP7SEW5BxGmAgEVwHC524/qlFsWlrk9mFapmiZcV4k?=
 =?iso-8859-1?Q?yB3zBupy92r+Eq4IRP/VpfzqEUudiKpDLZJMMG0Ky9NYtgYcXlebC4T+eD?=
 =?iso-8859-1?Q?NLsBnN8Mdz6P2O0VkaBPvVFD61IYJ0dlMX/PjqESZW5qXSTQ1rNr/RVtEJ?=
 =?iso-8859-1?Q?pFSBzSlbtP/wo/YvLWaP7VRfOmOjNap2H87CQplXKfebvJLyo39wQW3qNY?=
 =?iso-8859-1?Q?DTzTkwOQrgfzNd6ZvGNKfym6vji3wCFg55cRZamSWIsw/Cqfk46/XDVq/i?=
 =?iso-8859-1?Q?q/om9BoHEX8XpeIalK7w87e1ybS97NQcx+uk7ljiD7gSrJiHP+u6mWCCHi?=
 =?iso-8859-1?Q?VK4YTav5pStyzID8tdmv5kmgPiXmLqFIYPkRHppzxgQqIkMQfoBYj4A5cX?=
 =?iso-8859-1?Q?mTQTZehZxQrnnEcwowS/ddWgT8RsRgVmuDTQzOTBfnLSv/f/K8VsFrammT?=
 =?iso-8859-1?Q?MthN+jobmSZW2AD9N1+Z1taifnCNQSZ0eyBhdBjicniMXl+rwmbp250eAO?=
 =?iso-8859-1?Q?znW2c9k8Rf7hqixubWW8igPXqCGPzZ+cD1Xqx//o0U2r6wc/LJ973fiB0f?=
 =?iso-8859-1?Q?y/E8ig/XXQVBSGhi/0OQLuA/e2PQAxkQDCfGFPDZRB/Hqu1mjiG5UpfEqZ?=
 =?iso-8859-1?Q?o1VpLoNfeWhd8ptYpg1zbY2fswFGyP7xtIvt8u8X3vEclnEqld9zVbr2nQ?=
 =?iso-8859-1?Q?WZfgpsU0pIVE2MzsO0oUYcGFfHk6kmfkhM4b5VLr4T2asRQs5xSMeJBAXB?=
 =?iso-8859-1?Q?afzqEtWCB+xQcYUNCXKVzU82g//4Z/qfJRBvkyg/UH19u6HjKdBbOxUjMF?=
 =?iso-8859-1?Q?Tlvg/Kdoix23p9bnJlveeqR6E6AJRU9egltJ4Awq1OWPxD5yPxKoNWQa/U?=
 =?iso-8859-1?Q?DLfcn7Tb4EpYKcAvzrLfoEFPYReTzAfKQnblnly3w5S33k/EXwBv+SrLCj?=
 =?iso-8859-1?Q?x1eW5ycFJiMWc+Ieu5XVV6vEzg6kFt4QMrXEU2UOw=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6ea25.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ff48bf00-d726-48bc-bcc0-08dbcbcecbd9
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6719.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 09:28:46.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7307
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings! Sir /Madam.

Congratulation you are among the beneficiaries of 2023 {IMF-UN Grant} recon=
firm if your email is active for more details for claim of your Fund Grant.

Best Regards
IMF(Grant Department Canada) MrsOliva
Communication Secretary, www.imf.org
