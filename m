Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ED477774D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbjHJLi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbjHJLiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:38:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F351270B;
        Thu, 10 Aug 2023 04:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO7AaRphuY9wNunc8+i5MxVA3ABGqijHoCOVHBsFVOm1yEELkCnpZ6WRUHUvkEEiaZ35ANq0fO8IObiU+23xyQsH3WkJSrwZtIU8yDH9bRhr4o75I/KxGzboOBG7Glumk3LTAGNsXOd8lN+h1FOEfET3QUcCVFLOVDJnFaid4n1zt4omHVZF0MElaFW6s3jU4FD/iO2vcDjWBGvN7OHMzhZ5hmerW46oySdflD19mmw8b3ASXgsCXetxSAXxtWT6lXcLauaYKuOKz4WSX/dMFPZ/SrIWMZccUwH5SJ95j7HlSwnNYKTHW1E+Ye500gy5ht0+R9gUUHwYscR5aQS6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Wo3oYxB962TIChX9B6diJMrNkxLQpa0v1NDpVDuuRk=;
 b=DiW376mcCiBpstvp5TPn7dvGtPeIBxvQvC7N8HA3brQj40qPCGh5RZH/du6fWIAdJ9BSUBl15syc5Awgwb267+a+5oi2l87d4PGk/S2U7SpYZD/o5VVI0IdNJt2JJ9UiFVXrL6gOVRCjfrh2ff+FaDoc9OET6nzPAyVkD6v0NXN41P3/xl77kT1FqeVfElNzEG5Zg7WxUEiTWmSlXg4p4Oif+U9IqwFbLLk9eI1oIESn/dOQ2aZxB9P+Ptj2aWMfdS79uICoQGLclW1qEb4RuPtuy/pIcT2RMxeZk2zDAy1h8gbJ7+CQ4FQqQnZgM9aCJJletlHLA32LjNs0ix7g1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Wo3oYxB962TIChX9B6diJMrNkxLQpa0v1NDpVDuuRk=;
 b=m/9oNgycN9NiQAp5uEKKRhTb0x2v9z4TtlXGBPy1vVmxWJZVtSUm4gNl/TQy6UdiWJDsJdvTimCl0ruzGPSCz2V+5lnXGxQMN+ZJ8MxGaarw2HnJ0xJ5FudGUtkooUIhBXZ5+Q+sNyb8Fz2ZsqcupWa5EUsjpI3ZoJQ11hMy1pY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:38:17 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b%4]) with mapi id 15.20.6652.026; Thu, 10 Aug 2023
 11:38:17 +0000
Message-ID: <62adb14a-103d-4d29-9ecc-96203468e447@solid-run.com>
Date:   Thu, 10 Aug 2023 13:38:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sfp: handle 100G/25G active optical cables in
 sfp_parse_support
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230810094817.29262-1-josua@solid-run.com>
 <ZNS+aqPiaNRJ+SK1@shell.armlinux.org.uk>
From:   Josua Mayer <josua@solid-run.com>
In-Reply-To: <ZNS+aqPiaNRJ+SK1@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0113.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::10) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB8PR04MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: f01a1123-d3df-4539-2a95-08db99964a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I35W1dELa2wt4ylaVG/DfecNMVDgUbLZPMnv/S8Ge2rkCndcdDvOWj7NEWP/su16/mKzyMC/4WSpJnzW6YXEb/q2jrg9hwzPJ8bq6YsaxURB0dM0mTpbjmXQXLMybodCwAhYI/on0rOUo8dupj6HeuBkASYtcVCzeOYlqciOE5MQTNx7shpGyQZk9J+DlvTv6n635A9dVb4G7mUSWHudxgDUZmeLhrVY45hUNgFT48/ocy+VmtMzrZb6xuNXTNMvTly7jxctJlFHE4NcUFG0QuKtVQ4XdMqIWqRl7BTthAPZCcCEjB9fB3ghxPYP4ysdl77lc2VZjMI+SP0OeWZo6JpTktvsMAUwjpQjTARQtx6IS8HRRj8rV5x6JrVsM7Y4J80ChQGay6NAiHOsYTtKZRBbMRlKPG9E7ncfhjmnb/BT4716BtPNIi9B/JYsdcmm3n+RQUq/IghRV9Bf549mKYDEw6JiZUuIWZOfMdBFArgr8zTfVsg6JaFUsYPbmRf9gws/edaE4hDDNfuOJXDB6JJzc0VCmuL7Ep6McsHkRnyF7JriJChopC4+kNPY38PqElrAhtSmgrtzpDY7X5jmU7c+DRzykghZwQ8rTf3iqDPiCfCKIP/RPq/Z8SAKzVSH6l+kvSvvr4EPSGfLr/Y4BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39840400004)(376002)(346002)(136003)(186006)(451199021)(1800799006)(41300700001)(31686004)(6666004)(66476007)(66946007)(66556008)(316002)(2616005)(8936002)(478600001)(6916009)(6512007)(2906002)(4326008)(6486002)(31696002)(86362001)(4744005)(54906003)(38100700002)(26005)(8676002)(6506007)(36756003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZWRHcyTGt6RHUzWmdZVDJOOU44NnN3bGVxY3dkYlhaWFRGM2hmZElhUFdw?=
 =?utf-8?B?ZXduT3NrQkd1Q0w5ZDJ0N0ptd2laY3JhZjluREhsUk9vTGlRUFBqWWlMTnJi?=
 =?utf-8?B?THowcE9kMktpWlZUanRFOXBDcXFiVEMwbVh0dHBUWlpQbGxTdEYzY1dsN2cw?=
 =?utf-8?B?YytsNkdJVkNZVjlzZExrTU4ydlVWOCtwYk80UCtTaDYxRFFLa1JBUlVTWUNP?=
 =?utf-8?B?bXk5dFd4clBLNERwa3Vmb0o4dGtXVFlmMm84dG1VTytEODlJWkFMMmg4Y0Y1?=
 =?utf-8?B?eTE4a1FhaG8ybmVvTk56RUxQdEUzYkpabEd4ZGRJV0h1K0FWNzJrT0ZiN3c1?=
 =?utf-8?B?Q2NqLzlwOUdBb21hUFE1clNyQ2F3N3QzQzhGM0wrWlBJelp1WUJxUXpYY1RL?=
 =?utf-8?B?YWpua2R1dnozVnkrK1o2a2xCdWdTd25RSTJYMVpiYXRNeUJJUTh4clRDdkhu?=
 =?utf-8?B?QjJGbDFDNzhodFVLOWVkNVdlMVRsWTVQbVZNUXJydWxSaFUyN0hIaFRETEtE?=
 =?utf-8?B?YU8zZU1JazhDQUw3TXY0QkZPV1VDZ0tUWE9BYU8wbGJXbys3alZsWUNlVHQ2?=
 =?utf-8?B?bUdJeGw3VXZmZDJqY0ZtTmFmLzhuRkNtWWxxNHJiOCtkaUp3M0xCVUZ0TEV6?=
 =?utf-8?B?NXZ4bGdVeGZqKzdqSzhlb29sWS9PMkJ5YmFuWlo2cTdoMlRoaHNSNVd6ZjRq?=
 =?utf-8?B?a1A5YlplN0VLYmpUS3NjYW9Ga01mMXRFbEF4NEdKdEgvOG85bVpsZVF0Tjdv?=
 =?utf-8?B?aS9lelRIUmNTNlFiTkpSMCszOUJRUCtXVVlBTkg5clQ5YzY0ZWxOZDJvdi9U?=
 =?utf-8?B?eFlVOEJ5MHVhY09oeXkxdXRzYUlxb2ZLREZYdkl4Rzk4Rk1KTDVEczFMMG1I?=
 =?utf-8?B?TkxZRDNVc0RoUjAwc0hoU0Jtd0dEWHljWDk5bUdNZThVd2ZNRzNaeXBDMmZn?=
 =?utf-8?B?ZGxZSkl4c3BLVTh6OVc0YjZFdjU0YmkrTVErejNwdHJNeUhmL29MZUYxcDdK?=
 =?utf-8?B?Y3RIL3ZqVXppRjI1WjBiWVV0WTkvSmQvYXoxdk9YOG1mM0xxaksyMnRGcnNw?=
 =?utf-8?B?S2pjbmtYeGJEWTQxb1lxYk1LUkpJa0FMVjlqVmM3QWNlTEZBazJuZTdRb0N4?=
 =?utf-8?B?YVlGSTJTWHVMWHZRbENZTFhHTkV1M2ZCNTRPcjdTd1g4S3BzRVZwaExXNHp5?=
 =?utf-8?B?dEJaNmIrcGZVcEVPemFFeHN2QTFlWmdiM1ZVdURVajlKNzRxZktSd3dLd284?=
 =?utf-8?B?WGs1M2NtR0dxM0xuSTlweDc0WHNiV3RVNzVQZEFPVHA5dnJheTBVL0tROVhY?=
 =?utf-8?B?cUx1eXhXNmpQMS84eHBMRG5NUVY4OFZBS0R3R0tyOFRXUUZVcGpVWUxmaGVC?=
 =?utf-8?B?eGRuS1Byb2FkSWUrZVEybWx3b3BoMElHWVlLYTJwaTI0RWtVWllFbEV2bnpX?=
 =?utf-8?B?OVVyaUZTQ3UvaDg4RDlVNjV1UFUzNk1FbDMweVB3bmx2RjZRSkN0MFkrMHY4?=
 =?utf-8?B?NWVtSXJHWEFpOGYzbHI0dGRSNzRSemlQSGU5a3hMOGFkM3dyK1Z4NGhwQXRS?=
 =?utf-8?B?ekZOeE5TMjJLRVFRZlZXaXptbUgwdks0cFRxOHNqTVBIRnVmVEdSVXB2UnJ0?=
 =?utf-8?B?ampMSzRiekNFY2g2UFhZSk5UZU5OQnh2WkNqbTB1Mmp6d1JoZ0FSMWw0VzVh?=
 =?utf-8?B?VVl4dStvZXBXL2h3S0kyMFpRdkYxT3lselVxOVNONTg2MmUrMkJDN0o3eERJ?=
 =?utf-8?B?VXM0dmdLdnU1d2tQSU5LZ3Z0L1B1UjJQeldxOEhOZnVmdmNxSUw3a0xSTm9v?=
 =?utf-8?B?WDFIV2cyTWpoRmRXaHBxUXorRUtwdkFtYmpjcjNQR3lkcWsxM1BhaTQ5KzVZ?=
 =?utf-8?B?K0diMjJMbHJVQnB2WHJrZmF6ektUVFZNYXBieVFDSTM4OW52bHYvT2NXd0tm?=
 =?utf-8?B?R0tHbnZsRWg4cmtaSUZMSnFzcENDd2RsQU1kd1doTzZnTGxqVEFlZWxBaDVq?=
 =?utf-8?B?UWlsSEJMQ2dlcVFYVEJRckEyeXcrcWFDbTFubjVXZ2lWMVZFNSs2ZXNGRWhi?=
 =?utf-8?B?ajdEYjd5QkpQSmV6Tm4xL2s1RWFZUzJVdTI2THNBOTlCaWtmcnVlVEdYZFlQ?=
 =?utf-8?Q?RfgNT/OzkOR9rFpZiAknxE4ca?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01a1123-d3df-4539-2a95-08db99964a12
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:38:17.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stkKWw2oCVY2T5cG1BSL4dapA8Cuuzj0jdHp1DkNEF09ZekFQy5T8IoOUVNq8s2DTh8qRnoZ1Eq2HTvT/nZ+uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

Am 10.08.23 um 12:39 schrieb Russell King (Oracle):
> On Thu, Aug 10, 2023 at 11:48:17AM +0200, Josua Mayer wrote:
>> Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
>> for active optical cables supporting 25G and 100G speeds.
> Thanks. I think I would like one extra change:
>
>> +	case SFF8024_ECC_100G_25GAUI_C2M_AOC:
>>   	case SFF8024_ECC_100GBASE_SR4_25GBASE_SR:
>>   		phylink_set(modes, 100000baseSR4_Full);
> Since SFPs are single lane, SR4 doesn't make sense (which requires
> four lanes), and I shouldn't have added it when adding these modes.
> It would be a good idea to drop that, or at least for the
> addition of the SFF8024_ECC_100G_25GAUI_C2M_AOC case.
>
Would it be okay changing 100000baseSR4 to 100000baseSR dropping the "4"?


- Josua Mayer

