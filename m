Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB40D7DEF80
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346181AbjKBKH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346069AbjKBKH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:07:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D690112;
        Thu,  2 Nov 2023 03:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHpXXS6nU4VCzNUZ8FAHwSpjCejoGimyg9auGS5uHy/xMyl5RGKUb/QKa+K9YPP2YcgTS3nGF6gjeWsscn0H0+2mTzfLn/ChsBfQObZ6oEvk/BtQUasmgtHmjAe4kXpbI9u65VFa8yXOTXc6kHX+hS4VqJVw2KTK3j6QpoJXJ9aRCLRTmBDqJZ+OiSRgvpKkdBw92B8ohFqz2lVte13UodaliXwRemFUnp9K5ebk52comcc71vauqYdAFYsiS0/D4HiuByupfSbX2WIzLSHYSwg5q5lLj0/gletYcIwuQ7zWl1o61qRX7QoQAZUfodWd/8ScI732nPznxcLpNQgmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtytFtJkm+q3nCFrx8EePRhrFsnYNNBrUcfAwkAB9hY=;
 b=GqUiGJu32GsP4zzbIFsTY/qyw4/X8wcYPol9LYTrAgNPHM1b6zauhs/DJmLaaw6OE24r5nwv3fl0/FCnVA6mxGdu+7Kwab0OQICAP67WrR4+aBzYezTL2zpzCy61k86rh+cdzjbll0wqqJeKYdgGltyDUSMHW4UsJY6FeEzEhJsPrymBXtXltxBOMgfcjKScom1YeP1lU1GBp499rvC32TD0XmvpHd3Q0OGPRttJfTGNOczQrUGbByBmUqUpPjOqo0WIA7WFiBFeuPp12gby1XycWfl0O/UwzOvx9PCQis7CYyr5u30mGEoHvqKzlfd3B3HWjvgpZhm7m9zjdHbPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtytFtJkm+q3nCFrx8EePRhrFsnYNNBrUcfAwkAB9hY=;
 b=m9yaMga5yfVVW1McPfL9aFZquNOxV8cV2gfTlLBM1vyUWrL8EgOaWXwufmXqGR89U7M18Aq20+HAeNpsP4q2jGQGCSH7MueYr+e+etyWJHTYz4a58zC4WKq+GAKhDCa4XNBAPl097U+LsD/rM6zAKNtIONSrFyT5UgfvdGEhJwkaKq+hlcsylJ4/x4CXw6APT3+nrTbm013wEHZpa522jQzaaGhMo8Cs3inxyWKDEEAACeLAYNBr8W1Mla2NKNS99HT3wz0sGHFS8l73+Rj1IiYxi3A1uWxVMa0V6E5h9BUEEEFIVhdQ6OJva9OWyJjTr+aDESg+K/ld1lRWDNvGJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6749.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.20; Thu, 2 Nov
 2023 10:07:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 10:07:48 +0000
Message-ID: <e0bc7eb5-f1b9-4e99-a39f-ca6f31daa9d8@siemens.com>
Date:   Thu, 2 Nov 2023 11:07:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] remoteproc: k3-r5: Add support for IPC-only mode
 for all R5Fs
Content-Language: en-US
To:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Hari Nagalla <hnagalla@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <20220213201246.25952-1-s-anna@ti.com>
 <20220213201246.25952-4-s-anna@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220213201246.25952-4-s-anna@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 12da6b09-306c-48c6-5640-08dbdb8b911c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VGP32TxVEn0uqLyfbmyfpCgKDzTN7f3iXKhULtK6mh1eT4UqEBn/c32nTEI/I5y5s3nilwmgHzp8jTtyTXyqT0w9kCNYJPC4kOzUDsnUz9P2h1/QxJ/TtuDISVpvqtTs8Ahk+U+8Ka8xHLBiOqKmxsAr8F9mMqTs7ovJYf/ecTtajfWU2uJugrM+Qn8ayZ1XByhe0t2SFHm+p+oOAhYbQukU9DgMwH7DEA1bvonbLTylMto+YYglKqXHXM02kFNgosK4oY2CLKPzlhnSo3SON5hLObsxRI04LKsw02r9ZTRu5PV6ggRcqnoFAdVvj8cLpZ6MMa8yyeWP02NuU5Qgog1Psgggyt9YhDcn+WxUzWFEIu09h1FrJzjdxBpF1HQ1TyZX+9i5OBHxWP/bKWNQuG9Xjrozo81aV26xPd6sWhaTUW+/5nimXo4J8t8A3J0XSQgH9k+o0WpubCAthfpDSHSE5JSd715v+/9aOIFwK7kzRiz9UYlLV3T9eOviZ+1YBc00jN3ORynV+Kvyb2I0l5BCyIF3G7jPY6SxtSpkZaZlpT2SsIi7JdStQh0sT2JJXCdg/Aqw+p7yybgFWSbcWdQx6e7XXszNgxlHXXlLBSMdtv7ziacadJLZxB0vc7mAi8Lik9ue5QHSkeAa745KLXVtldKrw3J2tA/4sz8l1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(36756003)(6512007)(2616005)(26005)(38100700002)(31696002)(86362001)(82960400001)(2906002)(5660300002)(83380400001)(478600001)(6506007)(45080400002)(6666004)(53546011)(66476007)(8936002)(6486002)(8676002)(316002)(54906003)(4326008)(66556008)(44832011)(41300700001)(107886003)(110136005)(66946007)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajAwZ1pNNGpCYUFnMlZrY0JKU1ZZb1FnQ3FQV1dST0R2Zkc4NExQQmJSa2dS?=
 =?utf-8?B?ZnRXKzQwQWMzVUNOVUh2OGNRYjk3YzZZSmY3WDR5cEI0TnJldEFzWXVFVmdY?=
 =?utf-8?B?VXJXaXlYcXR5ck5NbTZ1Szh0a3ZGa3liMitjUTF6ZEI5MnhlWW5ITVJCOURs?=
 =?utf-8?B?NVB4bytJN0FqZWRXazFxMEFkczU4VGRvSHhSbFVpOHYyYzhyYjNzb08yckdG?=
 =?utf-8?B?L1lQMjZ5Q0R1c0U5Wmk5b2VCKzAwUitZbytEc2tYelEzVmhuTjYxaG9EeVYy?=
 =?utf-8?B?OXV1LzBxa1ByYnAyWGdLUE1HemsyQUNjMm5OVGw0cUsxZTRwYTlrK01zdlJG?=
 =?utf-8?B?eUIxdnUxNFl6VnRzODdBMkFxVUZMb0tEUEM2TytUa3dIaWlyckNRR0xJaE0z?=
 =?utf-8?B?VFZvRzVJSTlERy9HSlhJSGlDZWcvemRGdm94a3lUTjFSa0dNaklpMy83ZVJh?=
 =?utf-8?B?dlQ1V0o4UUd0RW12VU1kRzErSGVVMC85MzJML2tEd0t3QW1yMnh3L1YxWGNB?=
 =?utf-8?B?SHQwWFhXTFRHTTYzZEovZjFWOUlkT294Q0txS2tzZVZxMmhHLzBKSmd6ZkNE?=
 =?utf-8?B?bDJjdXF6eHdMdDA0bWJpN01LZUJYczh0NllPejBwbVZ4Umh3RFUrQ3R5cnVC?=
 =?utf-8?B?d21HUFNTT2ZxT0NhVUQ0bFJZaUhmaDRRQVoza2p6b1QvQ0hyM1E4SmpqRTVl?=
 =?utf-8?B?TnRWaTFLaE1LNXVoNE0zRWxPYkdKdE54cEp1OTFjZG9zWmticzkyaStKVmFT?=
 =?utf-8?B?ZTNmcE1RNlU3WkJNdTU2eXdHVmxXSzBlKzVBMngyOThTL2ZPa3p6VVhKOVJU?=
 =?utf-8?B?TlNpclJWQlJKeDh4SUE3dkxURUc3WHlNSFJkaHN6dW8zMkxCd0p6WkZsSjVJ?=
 =?utf-8?B?ZnNST2Vkdk9BeHk3bXNzZWgxTTN6bWJObHpWaU1wUXhFVWQ2OFZOeVZLSWgz?=
 =?utf-8?B?K2g5RTRqYVFyc1B1Zyt6a3IyTnpWVE5XbklmRnB4cUJjK0EwSVNwQ0p1dDFG?=
 =?utf-8?B?ejZHSE1qMkx5UG1MNDVWQXFUOHQ3VWd1N0Y1L0IwLzA1ZWpNdElJVFhuTFZX?=
 =?utf-8?B?bm50MWI0QVRKUFNvVWM4YnRaY0xRUG94UlFhUTdrZllzQnNEY1pKcGdpTTgv?=
 =?utf-8?B?NVBFallMOHlXVSsxMVpEUy9IcGR2aU1NWXVTMExPeTJzNzcrTUxyQ3ZrUExF?=
 =?utf-8?B?YVRYWUllYkpIbkJGNVZhM3lVejBYQTRvSkhpUStxd3Y0d2xOKzZjZ1UzMjFS?=
 =?utf-8?B?SDhyL04zMHNhbStmWGdZd2FsMmpXOUxvWmR5Rms2enF5bzkyNTRlQ1FQVjkw?=
 =?utf-8?B?cmE1NUlBam5SSnJqcUxNN0U5dlhWV3crR1pKb242RUV5ZDhLRnpzSHh6aWtR?=
 =?utf-8?B?T3ZDSUoxK2RSV2NvN3dpTUxlYU80T0xXQWxXTC9TRlVJUWl6cVd6T2ozeDdq?=
 =?utf-8?B?NmhJYmI2WDh4Z1dXNWNEd0ZmUjNJOGtiOTZFQTFCYVIzTGFKaTV2Q05RVTIv?=
 =?utf-8?B?MVRyYXZMemN2aXdnYS84cHVpWHhPYlljd3BURTloUUg0UVB5WVNqRmE3NVZW?=
 =?utf-8?B?ejRDbVJhbWw5Z2VHUkZ6bWtQcXpkNStBbTlWZUNnYW5sc0xuNUVLNFJ4aVZh?=
 =?utf-8?B?bVRyb2R1TmF4alVmLzVhUm5zRmJFS3YzaVlTSkhxeTZzQlJRN1hjLzM4eFlk?=
 =?utf-8?B?RXpua2cxOEFPZVlhTHlpbjBoeEs2NUFubjhiRDVjRm1Sb3FrSmozbWp3d1Vn?=
 =?utf-8?B?Ry9GR1pXR21Rdko0TWhncGVYWDJCNElKUkRBNG9uM2ZPelZvUHRHUGNxbFJF?=
 =?utf-8?B?NmQyU3hBM1NuZ2tITFBDV2ExcjMxZ1JnTTVoSjhZclR2UExaaXpzcWNnSUt6?=
 =?utf-8?B?TDlyRHoxOExjTlNIR2ZNWVB0ZGlGRUZoQTVmTGQvZmJ0TGo5aCtlZjdrMUNQ?=
 =?utf-8?B?bWhWR0IrSWNPL25PNzFxTUl5bTNWT2NSajFHM0ZEUitLQlFjZUlDSVFseGl5?=
 =?utf-8?B?K3ZRYXR1c2dGdDB4WGxBV3daQVlyYWRxZ2p1UnI2em8zbjhnb0Y5Qm95Ulhw?=
 =?utf-8?B?SEJqRjlBNUNUcEFPS3cxNnp1ZWhQNWR2TitML2hVUzV0Mk1EOWZFRXZzbDlQ?=
 =?utf-8?Q?pLN25HaZk4/13holwAqBmNJHI?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da6b09-306c-48c6-5640-08dbdb8b911c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:07:48.6730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHVsUCyhUa6RsnTJr3cuUrrOOUzEvuq7eriasKLyFxWbSzNmRDOYlfv9ufrottcbcnLprxe4VUMk5/TTgu/vLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.22 21:12, Suman Anna wrote:
> Add support to the K3 R5F remoteproc driver to configure all the R5F
> cores to be either in IPC-only mode or the traditional remoteproc mode.
> The IPC-only mode expects that the remote processors are already booted
> by the bootloader, and only performs the minimum steps required to
> initialize and deinitialize the virtio IPC transports. The remoteproc
> mode allows the kernel remoteproc driver to do the regular load and
> boot and other device management operations for a R5F core.
> 
> The IPC-only mode for a R5F core is detected and configured at driver
> probe time by querying the System Firmware for the R5F power and reset
> state and/or status and making sure that the R5F core is indeed started
> by the bootloaders, otherwise the device is configured for remoteproc
> mode.
> 
> Support for IPC-only mode is achieved through .attach(), .detach() and
> .get_loaded_rsc_table() callback ops and zeroing out the regular rproc
> ops .prepare(), .unprepare(), .start() and .stop(). The resource table
> follows a design-by-contract approach and is expected to be at the base
> of the DDR firmware region reserved for each remoteproc, it is mostly
> expected to contain only the virtio device and trace resource entries.
> 
> NOTE:
> The driver cannot configure a R5F core for remoteproc mode by any
> means without rebooting the kernel if that R5F core has been started
> by a bootloader. This is the current desired behavior and can be
> enhanced in the future if the feature is needed.
> 

This change surfaced some complex issue in the K3 core: Turning on the
RTI1 watchdog also powers up R5F core 1. And this could happen either in
U-Boot or in the kernel. If the kernel finds the core running, it also
expects a resource table in the reserved RAM. But as the core is
supposed to start via remoteproc, there is none, rather often garbage.
Sometimes, a consistency check catches that, but not always:

[   38.372844] remoteproc remoteproc18: 41000000.r5f is available
[   38.380324] platform 41400000.r5f: R5F core may have been powered on by a different host, programmed state (0) != actual state (1)
[   38.394910] platform 41400000.r5f: configured R5F for IPC-only mode
[   38.401941] platform 41400000.r5f: assigned reserved memory node r5f-dma-memory@a1000000
[   38.476997] remoteproc remoteproc19: 41400000.r5f is available
[   38.484661] remoteproc remoteproc19: attaching to 41400000.r5f
[   38.491092] Unable to handle kernel paging request at virtual address ffff80000dffffff
[   38.503704] Mem abort info:
[   38.509760]   ESR = 0x0000000096000007
[   38.514071]   EC = 0x25: DABT (current EL), IL = 32 bits
[   38.519578]   SET = 0, FnV = 0
[   38.523095]   EA = 0, S1PTW = 0
[   38.526355]   FSC = 0x07: level 3 translation fault
[   38.528974] cal 6f03000.cal: Neither port is configured, no point in staying up
[   38.531775] Data abort info:
[   38.541866]   ISV = 0, ISS = 0x00000007
[   38.545765]   CM = 0, WnR = 0
[   38.548814] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000082fdc000
[   38.555831] [ffff80000dffffff] pgd=10000008fffff003, p4d=10000008fffff003, pud=10000008ffffe003, pmd=1000000886609003, pte=0000000000000000
[   38.568623] remoteproc remoteproc18: powering up 41000000.r5f
[   38.569338] Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
[   38.574440] remoteproc remoteproc18: Booting fw image am65x-mcu-r5f0_0-fw, size 932
[   38.580644] Modules linked in: usbserial ti_cal videobuf2_dma_contig ti_k3_r5_remoteproc(+) videobuf2_memops pci_endpoint_test videobuf2_v4l2 rti_wdt watchdog videobuf2_common at24 st_lsm6dsx_i2c(+) optee_rng st_lsm6dsx kfifo_buf pm16d17 rng_core tee_stmm_efi tpm_ftpm_tee fuse dm_mod ip_tables x_tables ipv6
[   38.589862] remoteproc remoteproc18: remote processor 41000000.r5f is now up
[   38.615533] CPU: 1 PID: 283 Comm: (udev-worker) Not tainted 6.1.54-cip6 #1
[   38.615546] Hardware name: SIMATIC IOT2050 Advanced PG2 (DT)
[   38.615553] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   38.641945] pc : rproc_handle_resources.constprop.0+0x8c/0x164
[   38.647788] lr : rproc_boot+0x2fc/0x57c
[   38.651628] sp : ffff800009d53740
[   38.654934] x29: ffff800009d53740 x28: ffff00087f7d77f8 x27: ffff0008048f4c10
[   38.662068] x26: 0000000000000001 x25: ffffffffffffffff x24: ffff80000e000000
[   38.669199] x23: ffff00080227e038 x22: 0000000000000000 x21: ffff8000092bb1b0
[   38.676333] x20: ffff00080227e000 x19: 0000000000000000 x18: 000000000000028e
[   38.683464] x17: 0000000000000000 x16: 000000006d958cac x15: ffffffffffffffff
[   38.690597] x14: ffffffffffffffff x13: ffffffffffffffff x12: ffffffffffffffff
[   38.697728] x11: ffffffffffffffff x10: ffffffffffffffff x9 : ffffffffbfffffff
[   38.704862] x8 : ffffffffffffffff x7 : fffffdffffffffff x6 : ffffffffffdfffff
[   38.711994] x5 : ffff000802be1f00 x4 : ffff80000e000100 x3 : 00000000000000fd
[   38.719127] x2 : 00000000ffffffff x1 : ffff80000e000003 x0 : ffff80000e000000
[   38.726260] Call trace:
[   38.728703]  rproc_handle_resources.constprop.0+0x8c/0x164
[   38.734196]  rproc_boot+0x2fc/0x57c
[   38.737689]  rproc_add+0xcc/0x16c
[   38.741004]  k3_r5_probe+0x44c/0xe14 [ti_k3_r5_remoteproc]
[   38.746501]  platform_probe+0x68/0xc0
[   38.750168]  really_probe+0xbc/0x2dc
[   38.753742]  __driver_probe_device+0x78/0x114
[   38.758099]  driver_probe_device+0xd8/0x15c
[   38.762282]  __driver_attach+0x94/0x19c
[   38.766119]  bus_for_each_dev+0x74/0xd0
[   38.769954]  driver_attach+0x24/0x30
[   38.773529]  bus_add_driver+0x154/0x20c
[   38.777363]  driver_register+0x78/0x130
[   38.781198]  __platform_driver_register+0x28/0x34
[   38.785901]  k3_r5_rproc_driver_init+0x20/0x1000 [ti_k3_r5_remoteproc]
[   38.792437]  do_one_initcall+0x64/0x1dc
[   38.796272]  do_init_module+0x48/0x1d0
[   38.800023]  load_module+0x185c/0x1cc4
[   38.803770]  __do_sys_finit_module+0xa8/0xfc
[   38.808040]  __arm64_sys_finit_module+0x20/0x30
[   38.812571]  invoke_syscall+0x48/0x114
[   38.816320]  el0_svc_common.constprop.0+0xcc/0xec
[   38.821053]  do_el0_svc+0x2c/0xd0
[   38.821077]  el0_svc+0x2c/0x84
[   38.821095]  el0t_64_sync_handler+0xf4/0x120
[   38.831698]  el0t_64_sync+0x18c/0x190

(this crash was with a stable kernel, but same issue with head of tree)

This raises several questions:
 - Is it a hardware property that RTI1 powers up core 1 as well?
 - If so, how can we use both watchdog and remoteproc so that the latter
   loads the firmware for the former? We are currently doing that from 
   U-Boot, but what if that is not desired? Should the watchdog driver 
   take care to not leave core 1 in a different power state behind?
 - Can and should we do more while parsing the resource table to prevent
   such crashes?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

