Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE278FCC1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349302AbjIAL62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbjIAL61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:58:27 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94610E0;
        Fri,  1 Sep 2023 04:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icVKT9T9cgkU8OGO9H+3GNb8mi4Oj2z0p5VnfSxfnop1F/X55aKBd8u43txgono4jS71JDhE2N4oEVioK3NBy+MfruPRvTrHLnOOS86rX1jjJLYFedPOxN0sUc/a8brbr3UIrDexiUGD6B/jgWk26gkL7eT5sv9GbqbxXfBIjDEcr6Sa9ZCw/adl+Ca+e80E0hYQEtAOP0enqXvAsT5HoXEqR7cfUySTfRb6sPyJF9In2BiUFzYp9BNaPqz+qPfpWb0fw1+ZoWnHBMsX83Nzwg7sbQGXPFQP2PbFJHZK9wuxp6ejypasXLbKcPKc8pVyXwKaBOMx9vn9bRqZDBjwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFH2rC4jo3moEdUxywcQ87zA+pfKhLwSUC9hjOYrz5o=;
 b=FKVuLGPNOCMho03l5ol0MhpZ2S2yECLuH+wASV7VeXe/4YrEcn6YYgeEKCEhgSdczjdbt9PPadL4I2qimZT/FtFlLswB3O1PH5mjMlEr8QSDG/fRuhtRFE3jHrLVyIYxx0Evc4jYjT/JN6QWsrme4rBWDok0r0FWNCIlZS5MyybEfsMJdAVX5FttvX5IcLBt8+lGzVuBsfA8UwasHU1vdQP2Mu/VmvU4PBzPf2kCYoDUNvRF7Si+txUHZ/tVDkoyu933u1L4RzIrBSW4Cd0+OeO4oTrMUSqgSSp6Y5sDDzqAJ8i+a1jc95Y0u7nxkm3PjNtVYvOdSEn3jYCDOjWsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFH2rC4jo3moEdUxywcQ87zA+pfKhLwSUC9hjOYrz5o=;
 b=Tf82E4RaesaE5oybn48MZKz1dxw13C06hwjpvLipCXFasN/6Qwa3KI3a7XoBtg1KanA3UE3mUqGjFRZ8rRmkpkl4pb1WbSqWNWFjwPzLEYCgm3DUYCq/B1anKC2U2iCeIIThwi8LzChJqd6HGbxMuabXs5T4CWV8ddOMciSFVnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DU2PR04MB8981.eurprd04.prod.outlook.com (2603:10a6:10:2e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 11:58:14 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6745.021; Fri, 1 Sep 2023
 11:58:14 +0000
Message-ID: <831bc700-a9a2-7eda-e97b-e1d54dc806f9@oss.nxp.com>
Date:   Fri, 1 Sep 2023 14:58:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Content-Language: en-US
To:     Sabrina Dubroca <sd@queasysnail.net>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>
Cc:     "atenart@kernel.org" <atenart@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Sebastian Tobuschat <sebastian.tobuschat@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
 <ZOx0L722xg5-J_he@hog> <5d42d6c9-2f0c-8913-49ec-50a25860c49f@oss.nxp.com>
 <ZO8pbtnlOVauabjC@hog>
 <518c11e9000f895fddb5b3dc4d5b2bf445cf320f.camel@nxp.com>
 <ZPG35HfRseiv80Pb@hog>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZPG35HfRseiv80Pb@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0006.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::16) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DU2PR04MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a687fd-6f07-4a6f-900d-08dbaae2b8e6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eo7jpL2QGQa0NaKh2cJgPGCtu7TG/kG0khH5M3bAQIOTI85+jOVkRJYLf8/OdInrjry3zpNDN/SfRzF5edp4xWimF4RGzMXk/JLoG/0JkdOOfjhDEbSi5PgTvP2zKwVjEQWWeK9aXKm/RLxKWJgjwgRzIuNJLn29IVLsxXNevrq0Lr5tEulkzliF+Qlt3imBFnRNoxfPYCt7fxzmD2L3pEP4j+KVyFa/AhJ6lHlYkBEy5kT+Gc1WTE4vriPGP4CmZfs+myCfbGzdMvwVyDt3yLosRKRgnHpJCQaE2srJ95bPosf4YC4AxAv7TYt6azO5LuVDPuaQjzY+NCn5AuiP+sL1nKgfjXEogpx/9GqfMwysDANv4oymySqbnziSkZCVcDnff/xnlFYk8EZuHWIYbugCe9XX5xuIG2K2p1HR3vkgyji4cCjdpGdF5VoNlZ75W6GCiiNH9DAeFPNs1g3kOHuVHlGpDb+eRY2ab2GAvPWa5mqehwyi9smd2p2ANwPkjVKdmU8vzemYjudyKxSRUTd3cFiH/+5bDTLrDlT4QfOpaXHWGp9zl9swHtJPSxhPqKCUcdpTK+1+f6/qO31hgvF8wwE83CqXNZRKxyre/jBeJp6ohflj0+WdCBJ+ASVVVngjLkPYvKh7ilhCf77C3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199024)(186009)(1800799009)(31686004)(6506007)(6512007)(6486002)(31696002)(86362001)(38100700002)(2616005)(2906002)(4744005)(26005)(966005)(53546011)(478600001)(110136005)(66946007)(8676002)(8936002)(4326008)(5660300002)(7416002)(41300700001)(316002)(66476007)(54906003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGhrSGd1a0JSTm9vM3EzQkphRm0rK21pclBTajdReFJRWmVzTG1HeHJpRXZ6?=
 =?utf-8?B?Y3JaSlpvMjl2UEVkNG53WU1iWXFDVjZCOVMzdU9UdkJmczdsVGs5dVN3aFg3?=
 =?utf-8?B?MlpXNTV4WnNXWHFaYjVkb0lpRmF4Ti8zQVE3ZFc3WWh3U3FWNW42S0pPVXJ1?=
 =?utf-8?B?dFpYWWxjS2lsdzVCSjVYclFLdlFvNWk3cTVTVGxnSzBMZnRYVnZjVGJwalBN?=
 =?utf-8?B?aDNyNTZRTWVlMmZobWU1NUUwSUdPYjFkL096NThRcFZRZmc2TU8vaXl4bDYr?=
 =?utf-8?B?MFJBTDBXd2MrWXVBdzNRZGUrSHhqS2lsT3ZRUXdJaDFCbGRiRXZENU53RVBr?=
 =?utf-8?B?OXZQbG9Sc1hHNkUzMzdUNUY1bjhMVmtaNSsyRENpbnlJNFNCNzZCUEY1dllG?=
 =?utf-8?B?c216ejRsY1hUN29jS1lGWmNKaU9XWDZVWVJJYzJqdkFjVXhORTY0UnFtd3JF?=
 =?utf-8?B?SVVhQU8rRGF0ZzNRT2Z5WDJ6dGJFeFdYUWNuUHNPRWlPWUJxcHFPeW5WTHk1?=
 =?utf-8?B?RnFXMUpGUGlsN09Hbk5OV1VKZWl1UnpNTTdRN0UxL1lhcmFwTGlUejhPYUJl?=
 =?utf-8?B?ZVFRd3I0USt3TkJxZ3pveWxKS2FURUkrNGJGNHN5U2c3MU01VkRRTEEvY3JS?=
 =?utf-8?B?aERHY2U3U05laTdJRDFnQkRVRXduei9lcE93d0tsQ1BLVmRiNHZ1ZU1rdlhy?=
 =?utf-8?B?dU1Kc0MwMmZ4ZlUzL3JXTnpWbkNQektQY0pYczVjalV0bVNWdng3d2RudGR1?=
 =?utf-8?B?ZzM3RjFycjZlb1NpYWNmcjdyOHJDRnJvdXk0WU9aVWNvYWt3b0wyeXJtZERH?=
 =?utf-8?B?eHVwNnFJaU9QdVRTMlEzNVozV1ZNZ1BKSXYvQ2dHTVZ5dllYajFVQW5nbzdk?=
 =?utf-8?B?YmI1eHNoS1VzNWpiOVlRTGF1RElqbytPQ1o5SytxeVFXRy94cEFqbXVqS0lp?=
 =?utf-8?B?ZHZzNVBmRWtIRjRZWVF1VVZyVGVTWkFNMUkrMnNNdCt5cjc5VHpiVDlqeDA3?=
 =?utf-8?B?VVd6RHZVQ1dRdWIrNUNuSlBrVDJUOUp6Q3FHTFIrRUc0MXVKalQrWUZaaUIr?=
 =?utf-8?B?anE4RTBtMXJQcUJDL2VMMG4rdTYwM09hNmVRcTJFT3FNYXVXOGYrK2VEbk8v?=
 =?utf-8?B?bWRIWUdjYVNBOGNtUHNYRm52MVk1Z3JLUElPY2EzeTZQM1oyL20vcXUybzR6?=
 =?utf-8?B?MlhGWlNzaU5sVXlmVlNGQllSdXdsTFVVdXZMclFkaWNpTmxqSWFKWTN3VUJr?=
 =?utf-8?B?WkJWclNQRkVvdXhIa1pTRVdvYkRES1pBQ1dZTTE4anZ2bUpRVmQ2TWZDL1RH?=
 =?utf-8?B?WEcwdWxYSGpuWjE0Q2RIcW16VjRHdGI5Wm5oS1hkaVBpMVFYcGh2SHhEeHlz?=
 =?utf-8?B?QzRjeU9JK0Y2OStqdDhuQThpQjc5dGJOMjEzQndnZ1Z5NXFJVWhtNzJ5SW1L?=
 =?utf-8?B?NVorZE1QdHg2TnpFbG0wd2FBOFZrenVPTE51YXdreUtkZXNYWkFMeUt3eW9z?=
 =?utf-8?B?ZVZPZk1aOTBrdGh1WGFWK2h4NUpGeGdLYXdKdko0Smx2UXhTbFAvM25kMmd1?=
 =?utf-8?B?V3dDa2xQV3RCU2daTUkzQ2dBU01TTk5WZkNuSlBHMTdteEkzQ2FFMndKeW8z?=
 =?utf-8?B?STd6Y1pUK2JBejFJMkZwZHdqS01WOHJ2N1VwN3ZHRzhaSlJwcmx5Q3VLTmoy?=
 =?utf-8?B?YUFkdlVGTFlWN3NId3NtVWxFd0xhT25LbXZVdWNJZnhwblE2ZUYwblA4T1E3?=
 =?utf-8?B?ZmFyRndyTmZjMXp6dUs5b3pXMTkwNWZQRFZyQWVCbStFU21TR0VVc2p3elVB?=
 =?utf-8?B?OTJnVnRNamhSRDJieHpTbkcrVWFnaUVKRXhtMzBOajdxRUR5ZEo1eVdKTVlE?=
 =?utf-8?B?Z3gxVFIxRDBZWlcwYnlSV0F0WmkrakJzYldIckJDUnRReGp2WG8zS3dCVHdQ?=
 =?utf-8?B?QUw1U0h3TldSZ0dhUTRLOWhweS9EMU5xTXlqelU3OTNTdUVWcHBYQTd5TkVN?=
 =?utf-8?B?Vm9hOHNRSEJuTDk3MktSV3kzWkVSbGhKaHpzYnZ2ZDRVQVZ4UkhNczljNzlW?=
 =?utf-8?B?TndLZDJyM2prNExoU2d3eGN3TjYrNjFZbjhaUXovZzI3bzB4dWRaSHkxaUZO?=
 =?utf-8?B?Y2cwZ09SN0c4MVZaN0JweTRYNlEzaTRPUmpDVmxKTkRJdURzUWN4dnZkY0E0?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a687fd-6f07-4a6f-900d-08dbaae2b8e6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 11:58:14.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKX+6UWmbWop4T+UVhFhRX7WbviSacEQO8pZ+ZWQCq+NsOwUR9V+z6o5B3IIiX5tSZ5hDY6U1PhZupc4840+FaY7/eLarA8Ad5i/EENTKHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8981
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.2023 13:07, Sabrina Dubroca wrote:
...
> 
>>> And what happens in this case?
>>>      ip link add link eth0 type macsec offload phy
>>>      ip link set eth0 down
>>>      ip macsec add macsec0 rx sci ...
>>>      ip macsec add macsec0 tx sa 0 ...
>>>      # etc
>>>      ip link set eth0 up
>>>
>>> Will offload work with the current code?
>>
>> (the interface was up before)
>> [root@alarm ~]# ip link add link end0 macsec0 type macsec encrypt on
>> offload phy
>> [root@alarm ~]# ip link set end0 down
>> [root@alarm ~]# ip macsec add macsec0 rx port 1 address
>> 00:01:be:be:ef:33
>> RTNETLINK answers: Operation not supported
> 
> Where does that EOPNOTSUPP come from? nxp_c45_mdo_add_rxsc from this
> version of the code can't return that, and macsec_add_rxsc also
> shouldn't at this point.

This is the source of -EOPNOTSUPP
https://elixir.bootlin.com/linux/latest/source/drivers/net/macsec.c#L1928

-- 
Radu P.
