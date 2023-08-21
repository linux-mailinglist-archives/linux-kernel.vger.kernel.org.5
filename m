Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9E978246F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjHUH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjHUH1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:27:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711DCA9;
        Mon, 21 Aug 2023 00:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLNi2ZWTZP+Uif6uTDtmC5OAy4ohMkfj48q7VObrGkmSDRaXmIUXqMNJBhJMsez2ozxD3Ts6TSl5PhL4JWlx31dPuwTqAydDoPexDMNEiBkI1humsv5bJPSmnyOvX39prulpoW0d9tgkfUaly4Uc+Y69hetXdAaxJjzLYAXNE7o1AVhp/I+2hmNsTkm+OuWFEwEuo0XUTTfvNS5NEL4Bav7KwjMmkuHWdw7p+m7YFtHyyKHD605gdwnWJt1vZEsHb4Oe2Dz7+TR8HJK7+MIwygk1NsPpNHxAG5F53iEZphTRoaTRtoRTCQr13D+fktX9kcAWRX2zthBtLrg9oLJXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4kW/gAWJH3voBSc+hWr0+hEt4+aclO7f0UsCryeS4I=;
 b=nY4GnlGYmkoqNew5WcUCa6WuvFo4S7orwetctDCXFyzBmC4Eh0IMZ35YVFdfn/bb4zMnOzBtLIE2HvyyuKIl+bE1zhhJHcS6AuzfZG7beNfI2UMqdPmijfLk8a2tp7F0w2F58IbdP+7UMfGCjDq3ztMTWt9Zfh9Q1G96unHQIkJbGojVRIOAA88rGzfHuWmap0ErakKzFMgU3+OR46eix8hev3F/ZcqpjauhRXRTY76QxvpNYl5f6GcXtjj1mrW7Ec0kS1+xCB88PhneUlL6i+r6Iy3IbImcpp5fnDWxifcQ8B8eVuugLinSVTINiToO/JD2RtdFhtT2/Aeq8NXrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4kW/gAWJH3voBSc+hWr0+hEt4+aclO7f0UsCryeS4I=;
 b=S3O5jn0m2g1F6AwCwVgMcLNIXG05ZcHuoAP9+p52ANHeJ/rqZRAD1cUVQAxnxFyRAuo+yg5/I3Qu10rk/Re6ahHFxTaV/cwtv+cSHiNLV2ttOWFMsnux9FaBtzRgc0kLSSmjuw0wOSmEJL+A72vjDgG/P2CcOiclGeqdjhKp8HM=
Received: from PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 07:26:57 +0000
Received: from PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::6a4c:b0d9:9f2:d986]) by PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::6a4c:b0d9:9f2:d986%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 07:26:57 +0000
From:   "Goud, Srinivas" <srinivas.goud@amd.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: RE: [PATCH v2 1/2] spi: spi-cadence: Interleave write of TX and read
 of RX FIFO
Thread-Topic: [PATCH v2 1/2] spi: spi-cadence: Interleave write of TX and read
 of RX FIFO
Thread-Index: AQHZiWymuzIqz3Ot8UaPrMu6fkQ75K9nn7IwgHwzAoCAERN4kA==
Date:   Mon, 21 Aug 2023 07:26:57 +0000
Message-ID: <PH8PR12MB66754DDE4373E3667B882C46E11EA@PH8PR12MB6675.namprd12.prod.outlook.com>
References: <20230518093927.711358-1-ckeepax@opensource.cirrus.com>
 <PH8PR12MB66758946C395E678B7599FE5E112A@PH8PR12MB6675.namprd12.prod.outlook.com>
 <20230810100941.GX103419@ediswmail.ad.cirrus.com>
In-Reply-To: <20230810100941.GX103419@ediswmail.ad.cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6675:EE_|CH3PR12MB8308:EE_
x-ms-office365-filtering-correlation-id: ec043a68-de4d-4227-ac67-08dba2180042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p7U3bQj3woG9yTX3W1Og5RKC1g/XjXz2pe8DLRBsrqkY6NrfRsbwU/+mlOxHKdpX5LDD3ocRF1F11g6M9NWORLkTyHI3bFkXnhl9l8oBBJok9cdeSocREeGJ92cm5V0yC8W85j72XjKo6q+75j0LmdmFDY9M5PBY2EnW+i6gRHvpRVtdRLCERG8kwYiTU7drrQPL2mqrs8U3uE7nDKqZ1LCRLrVSnFIwhvxJvt14unMV62Ai9C39ibN7/9DoI5aLfOLv6PPjKzghAfksxhx6jFAEYHzjocLbaUK3noCh3bLtcOrI9k8JeituaXl1TeIPr3TRtvatXpgVRZRVLlIjGu/pXnBomcHd0R7AjMEQKyb3Ucdw2ZpXFjRY0mgoOzBBdoEX5LP1HQHTEeL/aTTIbpL56V8HOyGg/7YHHHEdgoSRqAV8o2CQkaNP6molkP22gamaEQsQUQveTHY+CAJz0bITZkliHvUvB45xj59kL8e4Jwk/k8WGkvsY3SG4aRjuhVqYh4hi5TEJ4QcFjWQVztBbPKk98rIJFloOks7HI/P7XbMFSMw1ctANpAqoy3DoAHht98NoJyU30dH2EW0uHQG8ru27qJpScJdEjtSxNnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6675.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(1800799009)(186009)(451199024)(71200400001)(38100700002)(6506007)(7696005)(122000001)(38070700005)(53546011)(9686003)(55016003)(83380400001)(26005)(33656002)(41300700001)(66556008)(2906002)(6916009)(316002)(66946007)(54906003)(66446008)(66476007)(86362001)(76116006)(5660300002)(64756008)(52536014)(8676002)(478600001)(4326008)(8936002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PDVYgeQU/Hee8u7LOUVFoFTd6Ux9GicHh6mfxLLraYxzlcdhvdmPXANUsPsg?=
 =?us-ascii?Q?ZKXkor/cQkD50ZMxZWd7XOQdBUnx61gkPIZEm+XiLssFeM91xqd/dJsjPYOy?=
 =?us-ascii?Q?KTzFwUWfzM6BryCtAljZM/ZKUDBsbGHaF/jSlVpCl8/hsq4rGwMcu2njhr+/?=
 =?us-ascii?Q?urvwwwQdE8sNFSaMfHwNvXtkptbSmZWIWLKvTMs3DxH7GjZD+LGSOdtLtE8L?=
 =?us-ascii?Q?dzLwYlrVHsQrytTH1bolSqWL0wIYjhN14aO5EPkg1uULyERGaK78Vd9fvJSK?=
 =?us-ascii?Q?ffyaJt9taOTirTPceQOgkLNZIhnkAX/cpT8fnNcpE4oiQXO3SzxmXV/xH3MP?=
 =?us-ascii?Q?qYepFK4wR4eT446vb8Qs8XTWAtN8KpZ3wNgMuC+63eoMs/wT/5tErOE3QoQ/?=
 =?us-ascii?Q?LOJw1fnykGlHfeLbpUg7R7mlmLHJcohMSf4RM65MeymT0SLgjyKkTHiLoTC7?=
 =?us-ascii?Q?pnpfuSC8zMBhzO8ysQhB0m+1bieXxY1KZpxjpPbG1s3NsnLoHI486rovPjhd?=
 =?us-ascii?Q?TyajeI+JjMrvhvUzOe+q4XEQoX4Pot6BFS1Gg8OH0lqR1/zxKzC8UoTjjnNi?=
 =?us-ascii?Q?tEdLyGLrHBb0s8PcK2lJfR4lP8oEzvDGCLGCA5gmujdEe6x+42YRrxhzal9D?=
 =?us-ascii?Q?DJzJ2Ds++53XkiOg/qYCIjFqKcxbmIy1iKcSKOgYT6S6neAxh6CLJS58d5PC?=
 =?us-ascii?Q?dYRLQQOtKfoFA7z/Fv/ohQGd4Dg10ok9xCc6NC2yyQ2hECMzrFG20j69HXPU?=
 =?us-ascii?Q?CD8l+fUMO8q61eZZsS+A+yjOLr4j3Fwg68T1NIUU2NOFvnOyh2fxZISB1YU0?=
 =?us-ascii?Q?RsRBQNmADp3E/5cHevWRaHhjwUzK2bhaRorHn80/VZEp5Md9stGwkJY8K/0G?=
 =?us-ascii?Q?U++1CAIfO10HSqae7L4mjSwV0FvDjOylQ/Ia1SUIPgPKZz+PrLtzdhLE9/XF?=
 =?us-ascii?Q?Z16D+wu6mCRq4r1ZJ2m1CfXFzX+z/uhRJaZQiUXhuVO4oytF+a1SU+fXxsIy?=
 =?us-ascii?Q?2F/wqEizM6rSiRWjwi7vZ3cJ+FYiO5SBV+HMjDvKPxizY3PjvvA2xTPf96xT?=
 =?us-ascii?Q?dOBlLH5YCtYVYXjoREQ3QF8+8EEPXdXVur6M/+Ptp7yyiZr45yzYW/iAMWPN?=
 =?us-ascii?Q?ltxsmBE/h2S3AdyGiPMSPB0ZKDaCJziNRHty/YLkdXpH870gifXIRhZ7liHu?=
 =?us-ascii?Q?kgXCsNhBKbVt+ecKtvlHeSmUmNApSstr3yHLIl/8n/jkd95aCZYNwRfnMgoR?=
 =?us-ascii?Q?SCZ3fmiPyfPJHuKTgq+GnkYQvLOVOBKNcBB+CSinDErStBsPjm8yeaKg9Yng?=
 =?us-ascii?Q?63ESQctF3m3zHe97rW3CiE3w/ZUT2ADZdgb+EmkD7WtKih1vSJHnRVCs31Vf?=
 =?us-ascii?Q?ezZw0mzWkzlGJY7qRfVnLmB3U3hjUB5zLGByNJp9EDvkDdhssHXS3j+TDNzF?=
 =?us-ascii?Q?IVXNajzy3hfyfIL73kaNYZVUim0yFAG3URGwoaWaeKjMttnCSZVGw3Ouk6mT?=
 =?us-ascii?Q?btCixrc0WamSURVK4hB5yLcVNlrbFpkPUIrmAdsaZXvKLocbWKiUshDH23Vn?=
 =?us-ascii?Q?ctfbH6sWN42qvhm9ofU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec043a68-de4d-4227-ac67-08dba2180042
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 07:26:57.0247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFiFeyVyDN90AchC3EQKHRCMC69Cgjz12ndR1i4kJQdV0fz4/cj5l277NHYXl7pD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

>-----Original Message-----
>From: Charles Keepax <ckeepax@opensource.cirrus.com>
>Sent: Thursday, August 10, 2023 3:40 PM
>To: Goud, Srinivas <srinivas.goud@amd.com>
>Cc: broonie@kernel.org; linux-spi@vger.kernel.org; linux-
>kernel@vger.kernel.org; patches@opensource.cirrus.com
>Subject: Re: [PATCH v2 1/2] spi: spi-cadence: Interleave write of TX and r=
ead of
>RX FIFO
>
>On Wed, Aug 09, 2023 at 11:31:24AM +0000, Goud, Srinivas wrote:
>> >+	while (ntx || nrx) {
>> > 		/* When xspi in busy condition, bytes may send failed,
>> > 		 * then spi control did't work thoroughly, add one byte delay
>> > 		 */
>> >-		if (cdns_spi_read(xspi, CDNS_SPI_ISR) &
>> >-		    CDNS_SPI_IXR_TXFULL)
>> >+		if (cdns_spi_read(xspi, CDNS_SPI_ISR) &
>> >CDNS_SPI_IXR_TXFULL)
>> > 			udelay(10);
>> Linux driver configured as Slave, due to this above delay we see data
>corruption issue on Master side.
>> when Master is continuously reading the data, Slave is failed to prepare=
 the
>date on time due to above delay.
>>
>> >@@ -391,11 +388,10 @@ static irqreturn_t cdns_spi_irq(int irq, void
>*dev_id)
>> > 		if (xspi->tx_bytes < xspi->tx_fifo_depth >> 1)
>> > 			cdns_spi_write(xspi, CDNS_SPI_THLD, 1);
>> >
>> >-		cdns_spi_read_rx_fifo(xspi, trans_cnt);
>> >-
>> > 		if (xspi->tx_bytes) {
>> >-			cdns_spi_fill_tx_fifo(xspi, trans_cnt);
>> >+			cdns_spi_process_fifo(xspi, trans_cnt, trans_cnt);
>> > 		} else {
>> >+			cdns_spi_process_fifo(xspi, 0, trans_cnt);
>> When Linux driver configured as Slave, we observed data corruption issue
>with Slave mode read when data length is 400 bytes.
>> As TX empty doesn't guaranties valid data in RX FIFO, hence we added one
>byte delay(10us) before RX FIFO read to overcome above issue.
>> Created patch with above changes, find patch as attachment.
>> Can you please test and let me know your observations.
>>
>
>Yeah I can test the patch, I am on holiday this week so don't have access =
to the
>hardware, but will do so next week.
>
>> From 40154932ac7486c99e339bbc0b85b3cfe382286c Mon Sep 17 00:00:00
>2001
>> From: Srinivas Goud <srinivas.goud@amd.com>
>> Date: Tue, 1 Aug 2023 21:21:09 +0530
>> Subject: [PATCH] spi: spi-cadence: Fix data corruption issues in slave
>> mode
>>
>> Remove 10us delay in cdns_spi_process_fifo() (called from
>> cdns_spi_irq()) to fix data corruption issue on Master side when this
>> driver configured in Slave mode, as Slave is failed to prepare the
>> date on time due to above delay.
>>
>> Add 10us delay before processing the RX FIFO as TX empty doesn't
>> guaranty valid data in RX FIFO.
>
>guarantee
>
>>
>> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
>> ---
>>  drivers/spi/spi-cadence.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
>> index 42f101d..07a593c 100644
>> --- a/drivers/spi/spi-cadence.c
>> +++ b/drivers/spi/spi-cadence.c
>> @@ -317,12 +317,6 @@ static void cdns_spi_process_fifo(struct cdns_spi
>*xspi, int ntx, int nrx)
>>  	xspi->rx_bytes -=3D nrx;
>>
>>  	while (ntx || nrx) {
>> -		/* When xspi in busy condition, bytes may send failed,
>> -		 * then spi control did't work thoroughly, add one byte delay
>> -		 */
>> -		if (cdns_spi_read(xspi, CDNS_SPI_ISR) &
>CDNS_SPI_IXR_TXFULL)
>> -			udelay(10);
>> -
>>  		if (ntx) {
>>  			if (xspi->txbuf)
>>  				cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi-
>>txbuf++); @@ -392,6
>> +386,11 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
>>  		if (xspi->tx_bytes) {
>>  			cdns_spi_process_fifo(xspi, trans_cnt, trans_cnt);
>>  		} else {
>> +			/* Fixed delay due to controller limitation with
>> +			 * RX_NEMPTY incorrect status
>> +			 * Xilinx AR:65885 contains more details
>
>Do you have a web link to this ticket? Would be good to get some more
>background.
Here AR link which contains the issue description
https://support.xilinx.com/s/article/65885?language=3Den_US

Thanks,
Srinivas
>
>> +			 */
>> +			udelay(10);
>>  			cdns_spi_process_fifo(xspi, 0, trans_cnt);
>>  			cdns_spi_write(xspi, CDNS_SPI_IDR,
>>  				       CDNS_SPI_IXR_DEFAULT);
>> @@ -439,12 +438,18 @@ static int cdns_transfer_one(struct spi_controller
>*ctlr,
>>  		cdns_spi_setup_transfer(spi, transfer);
>>  	} else {
>>  		/* Set TX empty threshold to half of FIFO depth
>> -		 * only if TX bytes are more than half FIFO depth.
>> +		 * only if TX bytes are more than FIFO depth.
>>  		 */
>>  		if (xspi->tx_bytes > xspi->tx_fifo_depth)
>>  			cdns_spi_write(xspi, CDNS_SPI_THLD, xspi-
>>tx_fifo_depth >> 1);
>>  	}
>>
>> +	/* When xspi in busy condition, bytes may send failed,
>> +	 * then spi control did't work thoroughly, add one byte delay
>
>Just noticing there is an n missing in didn't might as well add that whils=
t moving
>the comment.
>
>> +	 */
>> +	if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
>> +		udelay(10);
>> +
>>  	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
>>  	spi_transfer_delay_exec(transfer);
>>
>> --
>> 2.1.1
>
>Thanks,
>Charles
