Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF337982DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjIHG4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjIHG4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:56:49 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2074.outbound.protection.outlook.com [40.107.14.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16A61FFC;
        Thu,  7 Sep 2023 23:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdV78nE7QConi0cjFVO5oHN8z99UZgVFy9pTE07gbtQoCACZuTCK4wyqrTIH6U2ac94mtR7H+U4a5zscqktWdfJD/RDBVLy56IRUP+eAifgHg9XFkQiH+tSAxOvZSKdlSNk3LQ4a77tIc5ePaQuFOlygSUEMoO0X3Qfci/T6sjTN0gPwKcKDEHIVwDDJKLIgug/jwYLmNyQdkKM2eLscdUtpdsmHi473FMbK5HpaKWeEFg8SN2BtI3RaawFdZxw24RcOgxJE7/lmGjkamGAYM8see+DOaQIPpgtmm6H0jPAmqPGQZTVVNaNkLAsftSZnFkBqfHW9tVGqt7lmBdt38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkOO8XVtS/IPeePw9uxGxNMkkxWKIANN5NJtxh1X7LQ=;
 b=PZ4GEWx7LwfSxUwTWVvsErVmZv53pMo5fkQnkxbgG5ka7cv0LZcPaypolHArYbRJdOIC1wuYjrv9b5zBxH5l7fitHStkZJHLWXm0KQE+NGdhIK2P4kVxABe2xVCy1albRD/4eMBpW444pdDNkxLuw/SCAVv7EcFcqz/oFSowybFqFOMni/TQlj/NMrEb8KCCeZGmYYJW3MiqXAEqQ2KQpUuFQPN+5QUxqWXzF34UI1NmpTy9BKtzoWGg/Q5BNlFCHztuRCBzKe2nYxrXqLeVGkcyDgPLablIB4RzfXXPvi+FksctZWCpvEIs9eYB6TC2no6cAW6XoNZdhSM/llX08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkOO8XVtS/IPeePw9uxGxNMkkxWKIANN5NJtxh1X7LQ=;
 b=JFcHC+BUl0L5Ma1xV+e0ymYCIThS6KP1gBkTXPICc5mtQoYkaCYLhxZ7Y9rAjHTeTFLW/9sE+Q0Vtjjqgov1b2USMLqzS9nS1q5b/ns0zev+TCkU49RlwvfcxYnKY2Fmtie+rk8yOVGVSimt07Pg9cU3aF0j2Qclyetbpch/r0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 06:55:57 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%6]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 06:55:57 +0000
Message-ID: <0825855e-4cff-31d9-82e9-2e428397111d@oss.nxp.com>
Date:   Fri, 8 Sep 2023 09:55:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC net-next v3 4/6] net: phy: nxp-c45-tja11xx: add MACsec
 support
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
 <20230906160134.311993-5-radu-nicolae.pirea@oss.nxp.com>
 <20230907150058.GD434333@kernel.org>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20230907150058.GD434333@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0030.eurprd02.prod.outlook.com
 (2603:10a6:803:14::43) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 395a7913-a528-4ee0-afd5-08dbb038a6e8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyY2L4BQ5fbAm4bo6ozeahbo0IGZ69l3h02GO8FqN5kljdrLEA8aU0GVsiVEVAVUgBgFv2PFfb9oCR345t7ccSmuFy+c74DlgArDrAb28ujJ5dTa9NAcPI9q5b7CD04SANqHMGepVTB2sfLomYbotZr1im+Y+1V+AVzk4di2tik8FBCk4xWd0WRiGQS3HFZ0NevUwEOuFBgA0skMq27u3IHidzu3jCOVZgTkBRsL01IPpJcN3vGp8UwqveksDinewXJKq83hufndCRm7SXj2uiUedP7hpZbVpNRJqv67Q45gy2Qg9Y2kqXIOGf5oLf6JLydyQA/7L8uhwk0UrgtT8kngJm7+I+MG+TWmU0MIMI9pPpxWeLAwalPqSUcl2el5mkhS/N3PE6s/ect5F9ptY1GyFBoBJ/CMr6S2ZRunM468WUXmGGthhqaBgFhBAaRDvaPtHRXOvzQi60AkO1KYHXnGr/OKSr/9B7OVZKLFOm13xs/S0O/8RiiVPt8Jt/iCmYL1wzQGaS1F1c1wmi/c+RzYCeGCm5oIdy0xmlhRi2nIWRrYjMpce5FH9Sy0MYrcQupQ1VKHOTKQlZ/9mHrYfIoRgf8UC+eVC8yY+mrZAcK01cQRiUH5OzyuffZu11SeFMh5rSuk4/rI09MANgAURA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(1800799009)(186009)(451199024)(5660300002)(4326008)(8676002)(8936002)(41300700001)(66556008)(66476007)(66946007)(4744005)(31686004)(7416002)(316002)(6916009)(2906002)(38100700002)(6512007)(53546011)(2616005)(26005)(31696002)(86362001)(478600001)(6486002)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmNaNkUzL0I4a0VFb0llVDdSNkpjL3ArMVpzSENiVXVBczFrUTF1bDFzaTgy?=
 =?utf-8?B?MGx1a3YxN0NKOGM2VzBCY3lIaTFTWTR3cGxwM2sxZ3hiKzlUQVhic3FTMUZE?=
 =?utf-8?B?SEl6L1BUb2FURmljTERWaHdsdnZjVXpQTkttd3ZROVVNbHRac2tDQ1JHVFhN?=
 =?utf-8?B?VmxVMmpMcVEwWVUySHp6dVJsNGJXVkJYNkRvUkVHc29Fa3dGT0JWMlZHcFZk?=
 =?utf-8?B?K3daRjJsbTJENi84aDMzV2tOSDhucVd2TDlTUThkOGR2a3VxNXdHbkdMR1Qr?=
 =?utf-8?B?aml6V1N4RVhnNnQ5QWtDT0I1d1VndWtraEhVOWJESmIzejc4K2FTT1ZvdHht?=
 =?utf-8?B?bmt3VnkzOGxiOVpaWjExTGh0eTJ4OVhjTlRnMm1uZDVoSVZmWFRPYzMrYTZY?=
 =?utf-8?B?alJETXR1dDZ6YW4vZDRIcXVuUS9weFM1aUdFM1Q4WXV0U0NXZXVQR21ZekNC?=
 =?utf-8?B?U1c2L3BzTU1mNkpzczV0TExoN21aZkFIbnZJcUhSeEZjMTY3WG1hM0k0UFhi?=
 =?utf-8?B?VHl2V1NINERiOUVldXVydUZPdG5rcGIvaGlTWjFZbEVBTVdRRkV0UWlGdjFt?=
 =?utf-8?B?SVZVK1hFRklEVnI3VnhsN1BTeS9BZXNxeFNOZE0zMGdXSUtJWFNEU3oydzBF?=
 =?utf-8?B?ekk1cDZIb2ZHcmw5OFhLcjBheDFJV1ZHWk9sNUJGZ2lnVFhGaXBEOElpVGda?=
 =?utf-8?B?ZmVGNGoydFJRY2RTQWpzc2xMYk12UitsR0VBV0FNLzdhdWJId2lhMkM0R2Y2?=
 =?utf-8?B?WDdEUXlSa3piYVM0T1NNN2xYVWplMm54K3AvS2JkaTdJN21VQjM0V0tsQitr?=
 =?utf-8?B?aUVuT2E0ZjRDR1NlQjNIQVV5MituWUVsN09vKzlzSnVRMXdDenZlOG4xNHMr?=
 =?utf-8?B?Y3FyRUl1SzRHbW1lT3lPYld6U09qQ1B1ZjNUUHZJYnV6M1hiRWg4S0VQb3hr?=
 =?utf-8?B?Q1JlWGdFTTRiY3Z3djE0cHAwK0Rkb1hLQW1UbzBPMVpRNCsvWVVLWXdCaVV2?=
 =?utf-8?B?RER2Y25VdHQyS2FRUWt2eko4ZDdKNDRtZzQvMVBQQU55cFQ2dGR3endtVWUv?=
 =?utf-8?B?cDRTQ1YrWTBROVRXMTY5YkgvK2NSRityTkdmQVBCTm4xU3VZUW9sczd1bjNh?=
 =?utf-8?B?cHcyNlZqMzBRMEluRVdFaGR4Y1F5WG1IMyt6eFNRQUpzS0tGeUgvT2p3cWVo?=
 =?utf-8?B?aER0VkNSUU9tS2NZdDVkRWM5clcwbDVDRHZaVEQ4Zy9oZ0FaZGs4RnNTcEV6?=
 =?utf-8?B?Q09ZMHlUdHRBRnhHVUViME9NUURyb1VrQ04yZ0JhcmhPeW81amVWeXpkV2xX?=
 =?utf-8?B?VHluRHZYM29qMXZ4VUprdlZJZzN4S0FuR01MRDBEb3J1MDdNTjhBWnlSdEh4?=
 =?utf-8?B?WFROV3RuQlMxM2FQcFNOUmdWK3grMFNUWlp4UGdYa3N6bXI1RU1lUG5FQXY0?=
 =?utf-8?B?QUFINVJCbDNVemwwSG1CdlpYVmZieTZ5eEZpblM3YlhtZktZRUozSlJTTmRD?=
 =?utf-8?B?QnlxL0dWWStCKzRreEVpMUZzaDVteUViRDRXK3RWUkphN3A4WFE1QkNqSlM2?=
 =?utf-8?B?RERSbVhYamNBNUVqMDFQWmdQRE5sSklJeVAwaXJVNUFNRU9IWU05MHZ6VEhY?=
 =?utf-8?B?d2s5a1JCc0g0cUl6dy9USFZNU3NaZ2Nmd25keGZGM1FJTVBPelZUcjVaRWRB?=
 =?utf-8?B?LzJkVzVjTGhDMlM2UXorOVhKTTJjZUYyV0FwWnJKaE1KK0duOUhxVXhaSDd5?=
 =?utf-8?B?VTZjMTE2SmZ1SExhdmV4ejExdTEwdU9ZeEgzQW1SdXZKTExCV0VHSFlkc2Vw?=
 =?utf-8?B?aW05eVlFNmNxcHhkV2pTN25IR3E5STVrOVQrUWRpZkl4TkJjRmNJM0xEc2pK?=
 =?utf-8?B?bU1hbmRsKzdTNTdGb2E0NVZuL1EzdS9oWndhSzB3cmxLVjcrVG56bW5LQWFX?=
 =?utf-8?B?RWFjSTdQY2NEa09KZnU1YldKNjVYWnEzdmJKSEE0UFJkL21wWlhlbStEZVRy?=
 =?utf-8?B?VGt2Q2FyeThEQ0FTRUkrdG9kVEovUm8vU3lIbTN1d3M2TFh2WmJQV1QrMFhL?=
 =?utf-8?B?NWk0MjRHdEtnQy80VWlUVk9tbmtLYVQxZzl3bkNXaVE1bndFSnN5N1VibTgw?=
 =?utf-8?B?ZjZyRlpjM2JvK040d04xbkFlM0pCMjVTTDBSMjlJbzFQWXErTVg0cldMZk1t?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395a7913-a528-4ee0-afd5-08dbb038a6e8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 06:55:57.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVHWgcMcp+r+N2QuMG/UAd/lShh6pZOlNq+4a177Zaq5xYj6gHgpsoL+PonCf79Y9AmPSZufp+ydWibBsmO39ggGwSKwvM7RQkVJ4w/RxX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.09.2023 18:00, Simon Horman wrote:
> On Wed, Sep 06, 2023 at 07:01:32PM +0300, Radu Pirea (NXP OSS) wrote:
>> +		sa = nxp_c45_find_sa(&pos->sa_list, TX_SA, encoding_sa);
>> +		if (!IS_ERR(sa))
>> +			macsec_pn_wrapped(pos->secy, sa->sa);
>> +		else
>> +			WARN_ON(!sa);
> 
> Hi Radu,
> 
> Smatch doesn't seem to think that sa can be NULL: it is either a valid
> pointer or an error pointer.

Thank you.
I was not able to reproduce the issue using smatch 1.73. With the master 
version worked.

-- 
Radu P.
