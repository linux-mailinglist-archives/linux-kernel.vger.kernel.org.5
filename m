Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391C2801426
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379594AbjLAUOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjLAUOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:14:46 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF25A8;
        Fri,  1 Dec 2023 12:14:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQXoy00uj/CKJk2FIyRdyQLGSQjuVscem8oH9b2PFERFZBtH/jl0kdbCaSMR05BypqlE17r8h0Aulr8a/VTixkzs9S5AdcC0Y1an/2lx2KpWCKoKQ7nZQhi5Y0WHa4/RlKS0E9m1oq9PlXI3x8T0aslU2Lrs9ETzcZhN2CZjzKiGcL6v0GV6pQ5v50UONlZeFDn9UunCPeeqO1XUkM/yRYYRyD1OUrTsiDBqRnFt138yCMSogeP0UeKFIQCWfs+pIySJmpeVsW0Ex4qqNwr6B0N9VSXDCqWSh0f5YnLBhB85dbh5G5fRFIytPw+DLbzy75/8SI9I9h+0hMYV2p431g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/wB5Y3nXgp9MixbMHI6a5JCOkXDuSQevMM4zlDm3go=;
 b=XIBxhR4xKQknzWGiR324a94eE0DBNNcZD1Pzrjdxr1DncS+l1uAK+EggM2qLughhS7sqC0V7WN11ps/Wz6CBB0I1NTIzkYhrUFVifwDqTN2Y/39r4iWYt6NZyGZPSQBA+7gHB1QrBvCDwQ+A6/Cx4CfaVhSCwmb1mccwqSdY18IHIPAsrNaPyt8STI94EKssxzCe8ozE1ROIA4KXHKnYNOroeQtVzatI2rA5DqTKOY/lCdal/+Lh99J+znZmUIh48SFUBkanNNEEFxPNFztne9WSq+MK21hYlzC6LRKUeZuntTgqVldaEvYxJJvZJ6/wlS1N8EJY7Wg+5/af+RRV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/wB5Y3nXgp9MixbMHI6a5JCOkXDuSQevMM4zlDm3go=;
 b=uhdpIcC8GojWd5bRb9fAAFoeUTzHAm2ySz6K+QwyOJD0IMADIzV98YUUtaywzqhmQaGBz/DrrBVL1/n1N4xPRwMd42qtKtfcdNrXiRtSjiJKurxgP/o1MFjqPCsf/LYv4NKftprRgklUBP4fJQ+hk+ZrUOpLtoXQ/2tdMozoUBMPLhKMJ+iUiQqlQTg1fxm1wzUCqxOn4fbBwwH49KjJs/kYtKKZengeH4zE311LJCzZVEEioiWk/S+rGIHeZm/Fv5lGWkdErfMIhW+dwoqDE9hcuRHRry3HXjScjFY5AyP7vS0qopTrCACcSnjUproMg8ixuOANP5OyIaBN47Z9Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6478.eurprd04.prod.outlook.com (2603:10a6:803:12a::10)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Fri, 1 Dec
 2023 20:14:49 +0000
Received: from VE1PR04MB6478.eurprd04.prod.outlook.com
 ([fe80::775f:9e9:ef9a:6a09]) by VE1PR04MB6478.eurprd04.prod.outlook.com
 ([fe80::775f:9e9:ef9a:6a09%4]) with mapi id 15.20.7046.015; Fri, 1 Dec 2023
 20:14:48 +0000
Message-ID: <4ce32363-378c-4ea3-9a4e-d7274d4f7787@suse.com>
Date:   Fri, 1 Dec 2023 21:14:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, greg@kroah.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com,
        stern@rowland.harvard.edu, stable@vger.kernel.org
References: <2023120130-repair-tackle-698e@gregkh>
 <20231201132647.178979-1-jtornosm@redhat.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20231201132647.178979-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::14) To VE1PR04MB6478.eurprd04.prod.outlook.com
 (2603:10a6:803:12a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6478:EE_|AS8PR04MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: d719336f-4eb6-4cac-5d21-08dbf2aa2ad0
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g73qm4NihvHGcQw++nsp+XWKhOSclthWWpF+9mixSS/l8FFg+x1jmN74awNAGqKMTHTocu2yYKni3/Siql4Tj00DklA9X2e6Sf2lEP3ySw/teg2Td/LuweN20QQ0rj+1nN7EMrY7zg+oruOXt+INaI0KEWzraUC/GQtQza6fB1Kk1BjkJGfi06VFy4QZs6oUvroF+cembDT+aCe17kDKbot+IRMCiF/abY+QdzJqIvgLwuSfqfigThHecxgNY0bhoK5+jZE7xV+pf3vnK97fd6yDv9q4tk/9396+WEJT4sONJNStEsWN2Tz3C1RXp7a/hfBv+uA3IiUjVpX5SPblqso+8P1lkr+ZXwLZxmBgVCjcgdML/1/kGZKu/LXpYoeAKoPk47UQW/I3O9itYPB3Q6Wne23NY9j0lLxpLykM7bpZjtMGtrin81v9eB3ToDaX1PBtZZmA4wzhY7wuWLfJF2mWNuwHmHgPe0UUCCTC9QpDfocYEtOTxW8v55ahzg7j8Alrm/wZ95uX3uaa4+/qInJ2KIs/otk5fj+MiNBlVmR4wOtWvMrpdcWOhbvq4bTOftr0XUlOyoPMZCNFl/WE5/sUeN0YiJgm0x2ai7uLe2FCGDLsOhf6Caqtm+a9KxqIAVMZM8W6kUoiiMO8boTvzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6478.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(41300700001)(6512007)(83380400001)(2616005)(316002)(6486002)(508600001)(66556008)(66946007)(66476007)(6506007)(53546011)(36756003)(5660300002)(2906002)(7416002)(8676002)(4326008)(8936002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3NDMmdyZUJaajNGeHh2NFdVSXdIK1liM0d1cWhTbzZPZWIrbXFNc1c1U2N4?=
 =?utf-8?B?N2NxUS9JTnhQQytmanRldWFVanN1bGRuZXpUVlFZbWNISkVCZ3BPN0kwOU14?=
 =?utf-8?B?U0cxV0p4SnRmVlBNQzJMODVWL2ZMZjQyaG5vMnlFeHNlUzQ0R2xPM1NGb3g2?=
 =?utf-8?B?bXZuMTZvclJDVmNKZVhvQktLYkZEeFI1ZUp4ckRoYlJ3L00vcXlsUmpRVlk4?=
 =?utf-8?B?Ukl1NnlmZ3c4N0VPYlF6Nk5IbVR1MjJsbjM1QUxKVlduMEVSQVYwSnRuK2pk?=
 =?utf-8?B?K3lPR2pLL2FnYVdhQ2tWOEFCT0ZnS2QwK2dLdE8wUFFYR2x0ZVVPb1k5ZjM0?=
 =?utf-8?B?RWVsblRaWXdkcFBYVTJKa1RpU2phV1FJcCtHbEFrRjJiZkc3cGhTcFB5NEMv?=
 =?utf-8?B?djYydHVQRWwvSFQzQ1pDVWRaZnJxRFJKU3VlbFVzVU1iQ21nTEJpZHEyL1dy?=
 =?utf-8?B?dlBESEhZdHB1aGZUYlJYUFJid1AvYXZOeXFrZk14QzdiemZOK0pNOFRLN0Jm?=
 =?utf-8?B?b3NVQzZqRjhFdVJoajdRMDdUczYwZE1HNWhqZFdRcmhqMWxyQVRxRU1lbWZU?=
 =?utf-8?B?L3dDYkhnOSs5MHdHRlY1YXVuSERuM0VSeDVvODg2d3NzeUVXVnVDZDJkZGd2?=
 =?utf-8?B?cUFrT2R3N0x4UjNOQS84azB5WWtNNzUxOFBkbk9zMytIazBYUmY3MHhrV0Ji?=
 =?utf-8?B?V2lNb2k5K004VS9ib2thMkE1NWFFOTBMSnI5TWpvSWlTcEh4UVl1TWR2OFRU?=
 =?utf-8?B?UndPUWw4WjBUUHlkY0lnOU8veXFVYlBFM3Uzam5iZFgrTEYrQnU5U2RONVU3?=
 =?utf-8?B?clN5V0IvQWo2UkY0bi9heC9rYnFhNzVHMG0zS0JJRi9zK0lUWVRuVEdXNXlD?=
 =?utf-8?B?RU1YVGtkUGxnREprM0JCL3JmQ1ZSMVZkYVg1MXVobENQa0UyUnh4WXhoOG1O?=
 =?utf-8?B?YVM2M1VWbndQUUkzM2ZES05saUFTOXRUdjR0R0VLdzUvWThXSHZEUDNibnVF?=
 =?utf-8?B?VnA2VEluZHUrN3JxdWN1UlNhRUZTWlJnMWE3dnpQeTYyaGJ3aVlVbXkzcEtM?=
 =?utf-8?B?djhPaDhPWHVmZ1VCRzJndlJIOGNpTlNUaGQ0b0p2OVN2NmV5UEYrVFQyWFJa?=
 =?utf-8?B?OG5JZkJOcy9pU3FmNnZiUHJnaWdxMDdqZ202RDFOS20wUldTd0hFL3Z3UUhL?=
 =?utf-8?B?MUJQWEl4ZFpjaWJXTFRGNktwK2VCdVI0SHpJeEJ3cU9DSjBCTFpNSnp6TlJZ?=
 =?utf-8?B?dEpNUmdEOEE1aFZ1Qjdvc2Y2Wk5IU3MxNDBuS0k4ZW5EWDB5eGQvMmZ3VCtR?=
 =?utf-8?B?QjhnQWovbUI5QmhmdDhIdkpEZVRDN0Q0MGpoNEFlNTM1UjlDajhQRm4xZ3Nr?=
 =?utf-8?B?U080UElCUUY1dlU2VmpGdG5HVEtWcCt5ekQ5RUdhWG15Wlo3c1VwMGRic0ZE?=
 =?utf-8?B?VEJMR0hoVy9xUVlnZVJVZUVBeGp1SjlCNDExRzJXNExoSHVUdlJhdFZWeCtS?=
 =?utf-8?B?YXFxa1MrekJXcXJ2aGR4dWxBby9oZ0NsamREVlc4Unh5RW9QbTl6b2hNTTFF?=
 =?utf-8?B?bDlsaXVEbkdFQmF6Q3V5WWplcTFLSXZ1M2duVTVqTzkvTDl1eU9xTndqTFRX?=
 =?utf-8?B?K3RnVTNPZVZPdU5zbWp2Y3FpcFJlZlZ4dVhtUmVZb2lmSlVGeXVjYkZLd1Y4?=
 =?utf-8?B?WHN1OStKVFpNTGZZdWxjbE1RZS9DVndnaGhoanZSd1JSY3RoeUxpenpqT0pw?=
 =?utf-8?B?WEVjVUp2ZitwTFdUYmlZRHpqVzRITGpWK0gxQmdhT2NDUEEvYlNEbXdvc2NF?=
 =?utf-8?B?UTg1NXR3azBzYlROZUJuSHA1WFZaTEJxcHBic3czRWxEbGRvQ0dWejJxTXpF?=
 =?utf-8?B?TEF5MzR2Nm5BYTdiSkdYYjE0bEp0RHF5aTZKajRQaHdYT0pMRHg3TWdEdWJJ?=
 =?utf-8?B?M0FqRVFLQXVQUmljNDB6R2lyM3ByQWlYNjZ0T1dTTStKQlM5K2h6aUs4Yk9h?=
 =?utf-8?B?d01GdkhrU2E3amcxWlEydzVWVEd6MWpGcjVaYkJ3cWtqQ2R6QysvWEkrVU5M?=
 =?utf-8?B?OU13bWtrQmVFb3RRa2FyWktvM0VBNis2NHlSSTdUWHFsLzZQa2R1Mzk5dFZw?=
 =?utf-8?B?dHJyYXhlR2FUck9qZHVTS05xb21tSHY1bEZzZUZPVU9EV2JRRG5RcFd5UTJF?=
 =?utf-8?Q?KYyXTV56a8vfnBqpUEu9kdEQjeuoaVAgLCQcEvPz+NTB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d719336f-4eb6-4cac-5d21-08dbf2aa2ad0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6478.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 20:14:48.2663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5+dJYt0ZX8MGKNnBdfhtAEyqMMfUXCwW0IdogWOhT8eqK1TJCyiUdgPS1vwamxbcSoJ+odPa3pLWUyz4l54Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.23 14:26, Jose Ignacio Tornos Martinez wrote:
Hi,

this is much better.
   
> @@ -1661,14 +1668,19 @@ static int ax88179_reset(struct usbnet *dev)
>   
>   static int ax88179_stop(struct usbnet *dev)
>   {
> +	struct ax88179_data *ax179_data = dev->driver_priv;
>   	u16 tmp16;
>   
> +	ax179_data->stopping_unbinding = 1;

This is problematic. ndo_stop() is not limited to disconnection.
It is also used whenever an interface transitions from up to down.

> +
>   	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
>   			 2, 2, &tmp16);
>   	tmp16 &= ~AX_MEDIUM_RECEIVE_EN;
>   	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
>   			  2, 2, &tmp16);
>   
> +	ax179_data->stopping_unbinding = 0;
> +
>   	return 0;
>   }
>   

On a general note, you are going for a belt and suspenders approach.
It seems to me that you have two options.

1. Do as Alan suggested and ignore ENODEV. You'd be acknowledging that
these devices are hotpluggable and therefore -ENODEV is not an error
2. Use only a flag. But if you do that, you are setting it in the wrong
place. It should be set in usbnet_disconnect()

O and, well, this is a very mior issue, but you've introduced a memory
ordering issue. You ought to use smp_wmb() after setting the flag and
smp_rmb() before reading it.

	Regards
		Oliver
