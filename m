Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2093379BCA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358738AbjIKWNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242621AbjIKP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:57:38 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E641AE;
        Mon, 11 Sep 2023 08:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8bq0wyLEbYYymvYV6W+Kkyy56hf8MahMTYPO51VSvMbgM2IgkrgynUYkklLLuGmSp2r8FwpDUHher7hy2cTDzfjBbjxGn1YIJulocZW9QTosXren+DWCOKbd7QHj2fNWWgfxN1oAIpxxvl5faTvjopA1RHi2f7gaqhPBhItOPQFACPEM8UFBend36S22wUrzk3DcGHo98RLEL3RzGgdszSb2Z/8UVB33Jg6ES8CPNq2NrLV7EGbQaARKhrN6+XPIhYHLmjdsbfd3mzxLQ1Tp25XvGAE9l7trOxcPkCW+uF77oGfs4L+nGfFQEZmouEQuCcH/0EqPCryMwNlKnglTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGy4NPAN5yE0/IMp4kaDPVtbbpXsg7g+UH8eOL/1eWE=;
 b=DUwAYJ51p0cyca49f9F4E3xGmN5BwwCAMYnQNmveJwaszQZJEu4NyFF1xfLFzCdxkd//Ak7z2kgz1BxUgWQKdmY9rNXQjH4OEOB2kRvVR2ORMqVr6WsIJi6Osko0VrUmHdxXRnSNm2VEYjU8px1WaGAOigM87hd8RUg3T9hz6oY0xbPysBkSwGDz4Zzt8YImU1JTBIH3Y9Z46jXy+LZV1W2yldP8sH/o0hPjViYJwPOF4+l02W1Vk4spLWOAsuxEvUByMSM8bLkhGHxIvCKBA+j3l8drlGeih1dxF+npQmBM8t0t8i+krnLBNw31VQ8mzteS8yYZ5csTGMB6mwumSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGy4NPAN5yE0/IMp4kaDPVtbbpXsg7g+UH8eOL/1eWE=;
 b=hjFmwJgd1Urj7SwMxAIrdjVH0LrS9ekeunouhwl3U7HA2+DHG12CoXISJKqtEMlD68b+neS3GtYnSumPW+9b7UC1HUlx2mxWtG8gd5+ynDVzsy077q4El5rBPJgzlgltVZhQM5+Mp99nIJwyaXQQcyd0b7oI9EqY3qTl8aifXDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS5PR04MB10058.eurprd04.prod.outlook.com (2603:10a6:20b:683::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 15:57:29 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 15:57:29 +0000
Message-ID: <e169bc7e-b0af-a87b-e549-5fdcf447f381@oss.nxp.com>
Date:   Mon, 11 Sep 2023 18:57:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC net-next v3 4/6] net: phy: nxp-c45-tja11xx: add MACsec
 support
Content-Language: en-US
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
 <20230906160134.311993-5-radu-nicolae.pirea@oss.nxp.com>
 <ZP8BXxD0WZtdJ913@hog>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZP8BXxD0WZtdJ913@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0053.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::17) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS5PR04MB10058:EE_
X-MS-Office365-Filtering-Correlation-Id: c4733cb9-06ab-483d-a42e-08dbb2dfcd3b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w26zQsJfIuhnQcK6WKHpmao/LaE7/YNQjN49BaYI5+IU40600BY3uTugCLKtd1oUgzD2mf+ok9JY3GkjyEAjv1yXUEXKaki73FFFrSpffctRmj3PZpB9rrXkqHoPdTVKamxmyQwWINzBrQiKicA4t0QiuHHayYyZRHZ8FZedPdjxzqRa4Y4TuqA5HY9Rvs02huI+Y/mSvksHVhHwcDt9oMUhtZm/5LxNJUauksKi3pTi6hgS5hFiPl1t+YcLFTUB5vThcDXyrphoLcftV6e5NJCd7PD7mwv/nZ9ZIORwyjLYRxk3PZOfw2E3qFI40RLwz1mLmnU0QuNR2jtFH7Xw4LCBPrC6emlgb0J4azYmxVtLaWLZanN3Ud0cwvz0/hhle5HlflvCQ1UsqLw+Z0HkZowZFCtcfySIRqyvjTJ/CtOyrF+vJCuXh2UD9h/KGmZG6IYKmtcGs4p7Go9S+xijYALqRgk4XkHV2TpSqPPiUQgW0RIDyLR0lEcE/tJUFChkJ3GEGldiwlAgESRFRh7H6kvxqLCaz1l+uYm8u3aqT2poO6H1JAxnwnUwq8cEOyshsBBNclbYTcdnRU5MsyHrESI+UY3OTLzsxKr0uXcqYsLnJRQKa2JpJeNo1buGRc2nD6/iBYL/oDZkhPSggD71aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(1800799009)(186009)(451199024)(6506007)(6486002)(53546011)(6666004)(6512007)(478600001)(83380400001)(2616005)(2906002)(7416002)(66476007)(66556008)(66946007)(6916009)(26005)(316002)(4326008)(5660300002)(8676002)(8936002)(31696002)(86362001)(38100700002)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R24zM3U3KzRGK0drU3JmcjhMcDJnL3psY21Ta1ZCNzc3cGZCblZTQkJzUXdP?=
 =?utf-8?B?aytiYUlNcEM3VmZpOFZUNkY0Z05QT1F1TVpyQkxhTW9TNUkrR0xBSVNuNWk0?=
 =?utf-8?B?cytlWWNsM0JFQ1ZaK2hsNTByR3dKRUtrbk4vdEI4UGN5R0NueDJlaU9iTlpr?=
 =?utf-8?B?eEFYV1g5Y0lyc2VKbk9oWk5rYTlNMWswaXQxWDRJZk1xcEFBaHI5MHhIS05Y?=
 =?utf-8?B?U1pDY004S1FrRWpYSnArS3kvYWJoUTRRbEgvZFBTbjRLSUVOZVVURVZHWW4w?=
 =?utf-8?B?eVVCWVlUK01FaEo3dlhOUWRwUE9Sd3NhMlJJeU5wM0M0WENoOHdqYjZpaGFW?=
 =?utf-8?B?dDQxK3lXeldrWVJhTzdzaHB2MUh1bVg5VjFjcFVlNGIrUzlENTFWTTl3dFor?=
 =?utf-8?B?UzRERll5Mm9qWHFCc2Iva1prVlRFbGtBZnJIbis3a1Z6VjJrYkRuRlRIUFlh?=
 =?utf-8?B?b2ZreUxIY21uZkovQy82SnpEdXRrZG9zbm03UUhtbDlFMGg4UEQ4cHR1ajU5?=
 =?utf-8?B?UUFLVm5UMCtyQytLbU5yNFIvZ0xqLy9zR0pqZWFNU2MwL0FkSWNRcEttaHBo?=
 =?utf-8?B?dTd2OGNBcmVIVGx3WGxQQmdLVVY1WjFsN1N6MDFySFUweFNkT0hHQ2huMmUw?=
 =?utf-8?B?eEMvRUVHRWppeDJYM0F4V2R6QW9xZEZpbDhpbHlINFBDeHdtTER0L280MWRT?=
 =?utf-8?B?TVJ6Y0I5ZnlGMkhrcWVaa0hJYklneU9NbTFmcFM0WDBMdCtuYkFlcUlUTXA2?=
 =?utf-8?B?d0tzRklRYThWaEJ2YllUUTluYmpIcll1dVdMazUyMitqY0kxaXUzZ2pycFAv?=
 =?utf-8?B?T2dHOFFUU2JrRUFCdzJ2YnoybXpvZ2xtaEhKSXcxYldBRGZEZHBZcy9zK3Jx?=
 =?utf-8?B?SWRxRitobmROcmU0TldqejVQS0s4QXdPSk96b2Q5MGFRdGM2Q2x1T0xQUVlx?=
 =?utf-8?B?V0tNWHRvaXdEc1o0Yk4zS3dBU1pFYmh3dmFReE1xbE9PN3BHR0N4dUFPWDZF?=
 =?utf-8?B?dytNcXRyV2djU2JRdGlDbzArMEZ2eUJuQUU2UzJ2K2lpR3QwWkQrWVQvRUxW?=
 =?utf-8?B?UE9XK3F5Q2lDaTJLYzhwU3VtT3RxY2FtVmZ0V1RHU04vdzd5NHgwdnZjNDVz?=
 =?utf-8?B?VEQ0TXZSUXk1SG0rRkN2SzF5bHkzdEFyMWhSRTU3N3V3WXdDcWdPMUxUbU9U?=
 =?utf-8?B?MGNEUE5HVmlwUWdXTkZlS24yV0EzeksxR2tXZnNQRVhYam9XR3VJTVNzNVVk?=
 =?utf-8?B?a1hGWDVDdUpJWDRoazhPaVNia2N3MFJWcWNrSUhkYkh4elF3dHJMSm1pVTZY?=
 =?utf-8?B?amo0YzRtMERYL0FnZXNFa0ZEbCtFaUZiYzFtZjJDb3Z6Nnc4amZGR2VHSngy?=
 =?utf-8?B?bURheHU4d1RydjhvZFRYRzdkZS9sMFNsZlVhODRaZEo5cW1aQi9CZTJHOG84?=
 =?utf-8?B?NlgyQU1QalQ5UnJ2dWFwdHpMSGlmR0txZkkxcUJ2Sms1RktYMzlpMUFDM01u?=
 =?utf-8?B?SHdnd2lJQ2ZhSW1pdGdGM2p1M0pEOWRpQml5bHdzWlVrZU8xa1E2bXd3UFQ2?=
 =?utf-8?B?Q2JmQjl3OUk4ajBzOTVvZWtnQ3RpdW1XMTlMZ2dvd1FJRERBMVdlZlp1NStk?=
 =?utf-8?B?cGRFWEVDSkFFOWhHUFVYTmZnSys1NlZxZGRkMS9nbXJsdkhkTmtpcmdqWTJI?=
 =?utf-8?B?VEFGeDMyaWYrSGl1N3RPeWJoQTk2WmxLOUdMRDIyWUJWaW5vMm10NHc4MWxu?=
 =?utf-8?B?TVFLSEJjOEZTRnJtWnFTWE9Rayt4NjFXMzlEK205cUhuSjVYLzRGWEVHUmJk?=
 =?utf-8?B?KzgrVk1QN2kvYzAwSXA3RjBlWVU3RE9pNlg2di9aNzNUU1pxaDBpbG81RG4w?=
 =?utf-8?B?NklDNTd2V3pRc1J5dnJrMlBGbFhCV3lBeGdQaVBZbS9sWDR1akp2NXcweGpa?=
 =?utf-8?B?dmZzZXYzMndjNnowVmFMbmJLdGlXUWlkNnovK05UVlRYaHJTcmM3OFVZWkF0?=
 =?utf-8?B?dWNFUHZ5QS9ydCtMSmxTQ2I4eEpZRkdMUHlRbDY3dm50MjlycnZzaUZjNkhG?=
 =?utf-8?B?enovb3BnV3VQbWNzVFYxaGVCRmd5amMzckovYmR2L01QZmdQUU5McEtBUVZK?=
 =?utf-8?B?M1I1dm1RaElaR0ZLSXVxWUNoc09oMDVmczVHOVFUMDFMQ0VCLytVOTNjT25M?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4733cb9-06ab-483d-a42e-08dbb2dfcd3b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 15:57:29.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3qby8obDnVXJJPICW56BhhwpfMFjQihHAdZZgFmNvNYN0+OD2VNFI4JtuiUQa98JclEG7fKTCjsjrEHTb7bjD5CLgkLBJTBnmgCbbCsXkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10058
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.09.2023 15:00, Sabrina Dubroca wrote:
> 2023-09-06, 19:01:32 +0300, Radu Pirea (NXP OSS) wrote:
>> +static bool nxp_c45_sci_valid(sci_t sci, bool scb)
>> +{
>> +	u16 port = sci_to_cpu(sci);
>> +
>> +	if (scb && port != 0)
>> +		return false;
>> +	if (!scb && port != 1)
>> +		return false;
> 
> For non-SCB (ie normal case), only port 1 is allowed? That doesn't
> seem to match what nxp_c45_rx_sc_valid was doing in v2, but it is also
> called from nxp_c45_mdo_add_rxsc..

This port number restriction is valid only if end_station is true.
In nxp_c45_mdo_add_rxsc I forgot to check end_station flag.

> 
>> +
>> +	return true;
>> +}
>> +
> 
> [...]
>> +static void nxp_c45_tx_sa_next(struct nxp_c45_secy *phy_secy,
>> +			       struct nxp_c45_sa *next_sa, u8 encoding_sa)
>> +{
>> +	struct nxp_c45_sa *sa;
>> +
>> +	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, encoding_sa);
>> +	if (!IS_ERR(sa)) {
>> +		memcpy(next_sa, sa, sizeof(*sa));
>> +	} else {
>> +		next_sa->is_key_a = true;
>> +		next_sa->an = encoding_sa;
>> +	}
>> +}
> 
> What is this doing? Why are you filling a fake SA struct when none is
> currently configured?
> 

To reuse nxp_c45_tx_sa_update.

> 
> 
>> +static int nxp_c45_mdo_upd_txsa(struct macsec_context *ctx)
>> +{
>> +	struct macsec_tx_sa *tx_sa = ctx->sa.tx_sa;
>> +	struct phy_device *phydev = ctx->phydev;
>> +	struct nxp_c45_phy *priv = phydev->priv;
>> +	struct nxp_c45_secy *phy_secy;
>> +	u8 an = ctx->sa.assoc_num;
>> +	struct nxp_c45_sa *sa;
>> +
>> +	phydev_dbg(phydev, "update TX SA %u %s to TX SC %016llx\n",
>> +		   an, ctx->sa.tx_sa->active ? "enabled" : "disabled",
>> +		   sci_to_cpu(ctx->secy->sci));
>> +
>> +	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
>> +	if (IS_ERR(phy_secy))
>> +		return PTR_ERR(phy_secy);
>> +
>> +	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, an);
>> +	if (IS_ERR(sa))
>> +		return PTR_ERR(sa);
>> +
>> +	nxp_c45_select_secy(phydev, phy_secy->secy_id);
>> +	nxp_c45_sa_set_pn(phydev, sa, tx_sa->next_pn, 0);
> 
> The macsec core doesn't increment its PN when we're offloading. If
> userspace didn't pass a new PN, aren't we resetting the HW's PN back
> to its initial value here? That would cause replay protection to fail,
> and the PN reuse would break GCM.
> 
> Could you check by inspecting the sequence numbers sent by the device
> before and after this:
> 
>      ip macsec set macsec0 tx sa 0 on

Here the tx sa 0 pn is set 1. I will store the initial pn, and if the sa 
is updated with the same pn or if the new pn is 0, I will not update it.
Thank you for pointing that out.

> 
> 
> And same for nxp_c45_mdo_upd_rxsa -> nxp_c45_sa_set_pn. Testing would
> require enabling replay protection and making the PN go backward on
> the TX side.
> 
>> +	nxp_c45_tx_sa_update(phydev, sa, ctx->secy->tx_sc.encoding_sa,
>> +			     tx_sa->active);
>> +	return 0;
>> +}
> 

-- 
Radu P.
