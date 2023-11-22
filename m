Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0816A7F51FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjKVVAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjKVVAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:00:49 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D941A8;
        Wed, 22 Nov 2023 13:00:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8FDfOj6Xsdxu4mVb6yuYYchKWKd2hLykG7RP4Hg/heTi3rfXLF9k6ERzBkJpsyiJtB2XV4pKuNisHZZaVgON5/F/P6K0Sc4n5u78VnVPciwP7U/mCFPMrEqn2yNndUVgkMMWfqyOJzchX8cdfTjvCl69zHHdBY8DIbkKFmsbSnfRXhdPD7s9mwth2B9TVCmAiLsuA7QLazZoV2FmdjUgBNfMhntgvvixhEjStadJtgyLY5AAbcAMe61Y+OV8+zycCU70EAhHMzshBxkS6X8DIdSMkF9dJOcEt/rpWPzKrBXrMGhppL8+OgpKuzwX/5iIu52pCBEdhuPZCy3zBK9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pk9gMbxgnIsP6k96JL7z78zFj25W4uuJsALRPSiPd8=;
 b=QRooZJgp/pjkOErVYbAGH9Tzos7og2OU8ILSAe1lPkd2nGXKdzQFRzaoRjexmsqN7fHNfb1DIUP+7f1IS+o1SEPBsPi9S0rIL6WnYa3lOk4XrZkYayyP02pI7/sBmxUXjq2SGUPbspidRjNAcSvmXv9XGUTVXC0M9RkTgfhzMY2R2OMPU0e2RTgntv+IB2Q9fRmtm5sQi6uz3y2g7mvyI80WGMW0aVWDqVuEoAuNTLMbiwXiP81vbM60sNSms3XGcnKW/dLf4DubXfRrPFojlIx/h+vFrMUab3KT+w91IaQcIrHdWYGV+iO8FcAsAY6V2RnTqsFFvjUaO83R8j/mdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pk9gMbxgnIsP6k96JL7z78zFj25W4uuJsALRPSiPd8=;
 b=xENpe7cl04nQIpqOVdFGywcvezZYjlqExM2wKPXH6gXri1Vu4G8wt7QKjDt3aAwcG45VrRGM7f1XGO3WrV4eG3rfv0IdXz5l7IjFpQeQC3gMemIZfV+YEATIoYHb/YnGMwNsjF62+qcC2X/b1uQYqxNdX/rljTz6tnRlvEvevNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 21:00:39 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e%4]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 21:00:39 +0000
Message-ID: <93487d3c-c324-4b9b-8b25-0b4ea52237b4@amd.com>
Date:   Wed, 22 Nov 2023 15:00:36 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 3/4] remoteproc: zynqmp: add pm domains support
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231117174238.1876655-1-tanmay.shah@amd.com>
 <20231117174238.1876655-4-tanmay.shah@amd.com> <ZV02P3bHEhPLQHBo@p14s>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZV02P3bHEhPLQHBo@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::15) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b5106a-b8b7-45b8-01b1-08dbeb9e14d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0UYoIOvIzLpI6KiXN75at4sLUBgdlB3n/ZEmL0qPR/janDkvaxJd/18OvUoqfhu1w6lyhLMOZtjT4Nz6E3SzgIOf5P8AupvW3Xfo5i2jooW3pW3nQpDOlGtyP4tC3I5hGEfH6rCRy6D3+aos9ulm0LwkBtQ5rVVPmj+LUavkJKPC7M3jEWAZMO2YHIcLptgzJ646eJliLV9rOoa6YjKpnXfv5XY9oH5sRmd86RH1lVw/C9rRm1NFoRBud5Fu1p+0DfNoTLLyEJyx+BsYqi87pS9FPSFyJQzBjHKthPgl3frRf40+K8Yoew3TfZYZu4ufMkXYyBO7YYAAU/5lFP3dT04d7+iSiRf3XCXfX3ZqX7LPlDtrFVj6/yiSgGDB0PnX1Hrk/ljDvbnLFR8SsfPM+fSIfVz4OkUA4uSdkWb6OISFURwpAfli9wWDieliUEMnjsZsIEDNij67PgjUAQTNQg3ACJMQbSK6jaBsI5yeEf4cHx2y4/yqdghXDcE/pogYHPXgAHBD2iDQkeMMehojHlFl1f7KEImAdIS4V+wh6MZCEvuzpH78Z/dOMnrZNgo9hw4CGSnPHpuoganNLmXyFj1z/b5DPfQOZuXDq1BjVgR/Fq2KMmITpzn5uFkhWVfhFNVJCjMQcXI6/aK6VUlBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(26005)(31696002)(86362001)(38100700002)(36756003)(83380400001)(316002)(6916009)(8676002)(8936002)(4326008)(66946007)(66556008)(66476007)(41300700001)(44832011)(30864003)(5660300002)(2906002)(31686004)(53546011)(6506007)(6666004)(6512007)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNXTlpHWWpsR3BEcHl6YjZxTGprakFNbWdwbStESk9SblRoQ1JycmFyUjhG?=
 =?utf-8?B?dDNsTEFMa0NYS3prdFpYRWdhaGQrZWl2VlV2b0dHdWRDYWVROGM0b1FKTHJZ?=
 =?utf-8?B?bUxMaExrekgzUTlQNXovQzZnMHNRQ2l0RlZnYUZTMWxSckN0cjZjTWl1WjF6?=
 =?utf-8?B?bXl3NlpSYUkzcnFQZmYweDVHZHV4UE1yMW84Wms5Z1FReWtkaXZlWm9xa09F?=
 =?utf-8?B?cUM3QU8zTFJMMWZJZHh5NWtyc3BKSHRxckdySGxPU0FBVndOQndDcXp1ODZ2?=
 =?utf-8?B?VmN3SkFuN0twL1R4NkFOY21TZ1pNVEFmcmdqQjlZK3Nod1Frb0Rxemg4dEU0?=
 =?utf-8?B?Z2tQb1B0UDdkZ1JObUVhZ09HbWJQNUNiSDdORnY2WEljZ2lxSkViemNtZWda?=
 =?utf-8?B?MnViTFp0eDR4YVFlMXc4bXJqVUpqV2tjS2w1Q1U5VlAzZERyYjNxYklaWVNU?=
 =?utf-8?B?azVrVFpBNGRWQUxrK3ZCWHFMZ001OUgrcUV4NDhtemlqNjNXWjJxY0dkY2NZ?=
 =?utf-8?B?aW9jWU5IL1lYZ2tvdGdFRDJlaC9DK3U4ckUxbWp4ZkJZRnIrUmRNeEo5VXl5?=
 =?utf-8?B?ZG9kQVhNekU2UzlqQmZ0VmJZWkM5SUVVRTdacGMwVTBISTFWTkhpekhUMGVi?=
 =?utf-8?B?clBxUG9Pd3RreU5qRXBWalVySUlQYmdFb3czcXhnWmdsSzdnMVdhVy9oeWdS?=
 =?utf-8?B?c3RkZW10ZU1DTVNaVzFtd0Rza014bm1MOHF1cWpINzVIdXNmaHE0MzZGUGY0?=
 =?utf-8?B?QTBoalVhejk1ejlUdWdGQW5mSFlSRXdSc1BXR0txM1NPVXY3ZndiMkFtNnRD?=
 =?utf-8?B?ZFNFQjJRTXFNOXB3bXo0eExrUmFDOUZaenRJY1Q4VVhYb2l2WlplenB6S3Ba?=
 =?utf-8?B?Zy9JL3BlVFZ6UUk5UFc3ZUFCMlpSK3VBd1ZoTC81NlFQU1pxK0lNY3lWaVZQ?=
 =?utf-8?B?TjVqN3htNXRGdzhCRHhmODlkS2plY2EwL2pZbkV1bmFjeGt3OG5BNDVZTFZM?=
 =?utf-8?B?bVgzb0diYkR4b3duRUgrNzFwcG9Qc2ZoNC8rcklIL1h0OGF4amxFdlNPTCtG?=
 =?utf-8?B?bTJwcHJMbnhBVEpFZ0F2amlMa0l2TUpBK2Q5SkJOekVqNGx6Mjg0U1dRbG5S?=
 =?utf-8?B?ZXUyV0RUazZhTkh4WUZFWk5YRjFkK3ZPZDR4czhnRUpFNC9Fc01pcWtxSitU?=
 =?utf-8?B?b1ZrTmlBWmszUmFRM0FPRHBKMEtzT2ZBb3IzaGs1THk3cmJoSmR1R1FlRW5W?=
 =?utf-8?B?ZCtPak84Z0VjOExhRWZpc0FYU2hmMklOR1VvVUpUdHRaVDVFWUlFbFdDZ2k0?=
 =?utf-8?B?QkkxSzRZdjN2VytzRmhBOXhXazkyRUUrbWFQTGRMZzRVbVlQYURTVGxXQURz?=
 =?utf-8?B?dTdNak1SdWJuTnF2UVFHcnFoK3YvZFJZNGJ3ZHMwZFUvYU9hRlBWTkRPdTk4?=
 =?utf-8?B?eW5NVU5taUFhZGxtZUhseDBYVi8vNkNPdm05SklYK1NIbUtHOUxnZ0I2MnRF?=
 =?utf-8?B?SmJEQlUwUWtxa1V4MC9wRVU5bnNVanFYejNRR2JRR0lDeGxqNTh1U2JFNWVP?=
 =?utf-8?B?NmZRYTNLazc2Z2FNeXpBTW5BM2IweTZ6ZkhaektjQWhEWlFKamViODhSazBm?=
 =?utf-8?B?OW1ydnBMVWlFRVlaODIvS1pPbFFMT0xTdXNJRW1OcGdVS0xUeEdjbmk3TWdY?=
 =?utf-8?B?ekNjckRZa1pXY2k1WjZYM3dISXlkaE1MMEluNXFOTUxCVS9Zcnp1bDM3SGV3?=
 =?utf-8?B?a1I1SzY2Zm8reWdJWmdEa3o3K3ZSWWxjZ1MrdmNXTGxUcVorQnc1eDlGajlt?=
 =?utf-8?B?akc0b3U0N0RKMkJPSVVRUGtXU2dtRnZxQXRjaWtQUE4vWnN5UEZnN2VnUG1Y?=
 =?utf-8?B?UTZvWnpSeHZMV0w3WmdKU3A3enBzUDVsT0lzQTlDbkRwNmNsckJ1UkxaZlBa?=
 =?utf-8?B?M29MTXQ4ZEdnTTlIN2Jjc3N1YmkwdktJOHo1ZDlibkp1dXIwWVNHbTRPWk1o?=
 =?utf-8?B?d0hEUHFuZVNuT2ZYYVVpd1dsMUFUWnY4dzBsSFB1enQ1encxaFNXcEdqT3gx?=
 =?utf-8?B?R2swVnMrUVZWbUJ1L28ycnoydC9IZHJaSDQ4WlBtWUVkdEJmd1RseXhlR0tW?=
 =?utf-8?Q?+7w+9LgMM7AVkjuM0OmPnX4Da?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b5106a-b8b7-45b8-01b1-08dbeb9e14d5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 21:00:39.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkBxTq66mSdLqTdxYOCbpCYi0D5dfy075RUlqtRiSHgjPJ6iKFPm2TvZ1lvwS3xR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Please find my comments below.

On 11/21/23 4:59 PM, Mathieu Poirier wrote:
> Hi,
>
> On Fri, Nov 17, 2023 at 09:42:37AM -0800, Tanmay Shah wrote:
> > Use TCM pm domains extracted from device-tree
> > to power on/off TCM using general pm domain framework.
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> > 
> > Changes in v7:
> >   - %s/pm_dev1/pm_dev_core0/r
> >   - %s/pm_dev_link1/pm_dev_core0_link/r
> >   - %s/pm_dev2/pm_dev_core1/r
> >   - %s/pm_dev_link2/pm_dev_core1_link/r
> >   - remove pm_domain_id check to move next patch
> >   - add comment about how 1st entry in pm domain list is used
> >   - fix loop when jump to fail_add_pm_domains loop
> > 
> >  drivers/remoteproc/xlnx_r5_remoteproc.c | 215 +++++++++++++++++++++++-
> >  1 file changed, 212 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > index 4395edea9a64..22bccc5075a0 100644
> > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/remoteproc.h>
> > +#include <linux/pm_domain.h>
> >  
> >  #include "remoteproc_internal.h"
> >  
> > @@ -102,6 +103,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> >   * @rproc: rproc handle
> >   * @pm_domain_id: RPU CPU power domain id
> >   * @ipi: pointer to mailbox information
> > + * @num_pm_dev: number of tcm pm domain devices for this core
> > + * @pm_dev_core0: pm domain virtual devices for power domain framework
> > + * @pm_dev_core0_link: pm domain device links after registration
> > + * @pm_dev_core1: used only in lockstep mode. second core's pm domain virtual devices
> > + * @pm_dev_core1_link: used only in lockstep mode. second core's pm device links after
> > + * registration
> >   */
> >  struct zynqmp_r5_core {
> >  	struct device *dev;
> > @@ -111,6 +118,11 @@ struct zynqmp_r5_core {
> >  	struct rproc *rproc;
> >  	u32 pm_domain_id;
> >  	struct mbox_info *ipi;
> > +	int num_pm_dev;
> > +	struct device **pm_dev_core0;
> > +	struct device_link **pm_dev_core0_link;
> > +	struct device **pm_dev_core1;
> > +	struct device_link **pm_dev_core1_link;
> >  };
> >  
> >  /**
> > @@ -651,7 +663,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> >  					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> >  					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> >  		if (ret < 0) {
> > -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > +			dev_err(dev, "failed to turn on TCM 0x%x",
> > +				pm_domain_id);
>
> Spurious change, you should have caught that.

Ack, need to observe changes more closely before sending them.

>
> >  			goto release_tcm_lockstep;
> >  		}
> >  
> > @@ -758,6 +771,189 @@ static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
> >  	return ret;
> >  }
> >  
> > +static void zynqmp_r5_remove_pm_domains(struct rproc *rproc)
> > +{
> > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > +	struct device *dev = r5_core->dev;
> > +	struct zynqmp_r5_cluster *cluster;
> > +	int i;
> > +
> > +	cluster = platform_get_drvdata(to_platform_device(dev->parent));
> > +
> > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > +		device_link_del(r5_core->pm_dev_core0_link[i]);
> > +		dev_pm_domain_detach(r5_core->pm_dev_core0[i], false);
> > +	}
> > +
> > +	kfree(r5_core->pm_dev_core0);
> > +	r5_core->pm_dev_core0 = NULL;
> > +	kfree(r5_core->pm_dev_core0_link);
> > +	r5_core->pm_dev_core0_link = NULL;
> > +
> > +	if (cluster->mode == SPLIT_MODE) {
> > +		r5_core->num_pm_dev = 0;
> > +		return;
> > +	}
> > +
> > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > +		device_link_del(r5_core->pm_dev_core1_link[i]);
> > +		dev_pm_domain_detach(r5_core->pm_dev_core1[i], false);
> > +	}
> > +
> > +	kfree(r5_core->pm_dev_core1);
> > +	r5_core->pm_dev_core1 = NULL;
> > +	kfree(r5_core->pm_dev_core1_link);
> > +	r5_core->pm_dev_core1_link = NULL;
> > +	r5_core->num_pm_dev = 0;
> > +}
> > +
> > +static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
> > +{
> > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > +	struct device *dev = r5_core->dev, *dev2;
> > +	struct zynqmp_r5_cluster *cluster;
> > +	struct platform_device *pdev;
> > +	struct device_node *np;
> > +	int i, j, num_pm_dev, ret;
> > +
> > +	cluster = dev_get_drvdata(dev->parent);
> > +
> > +	/* get number of power-domains */
> > +	num_pm_dev = of_count_phandle_with_args(r5_core->np, "power-domains",
> > +						"#power-domain-cells");
> > +
> > +	if (num_pm_dev <= 0)
> > +		return -EINVAL;
> > +
> > +	r5_core->pm_dev_core0 = kcalloc(num_pm_dev,
> > +					sizeof(struct device *),
> > +					GFP_KERNEL);
> > +	if (!r5_core->pm_dev_core0)
> > +		ret = -ENOMEM;
> > +
> > +	r5_core->pm_dev_core0_link = kcalloc(num_pm_dev,
> > +					     sizeof(struct device_link *),
> > +					     GFP_KERNEL);
> > +	if (!r5_core->pm_dev_core0_link) {
> > +		kfree(r5_core->pm_dev_core0);
> > +		r5_core->pm_dev_core0 = NULL;
> > +		return -ENOMEM;
> > +	}
> > +
> > +	r5_core->num_pm_dev = num_pm_dev;
> > +
> > +	/*
> > +	 * start from 2nd entry in power-domains property list as
> > +	 * for zynqmp we only add TCM power domains and not core's power domain.
> > +	 * 1st entry is used to configure r5 operation mode.
>
> You are still not saying _where_ ->pm_dev_core0[0] gets added.

So, pm_dev_core0[0] isn't really need to be added for zynqmp platform, as firmware starts it with call,

zynqmp_pm_request_wake during rproc_start callback. I will document this in next

revision. For new platforms pm_dev_core0[0] will be added in future.

I hope this meets expectations.


>
> > +	 */
> > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > +		r5_core->pm_dev_core0[i] = dev_pm_domain_attach_by_id(dev, i);
> > +		if (IS_ERR_OR_NULL(r5_core->pm_dev_core0[i])) {
>
> Here IS_ERR_OR_NULL() is used while two if conditions for NULL and an error
> code are used in the loop for the lockstep mode.  Please pick one heuristic and
> stick with it.  I have no preference on which one.

Ok, I think IS_ERR_OR_NULL is more cleaner, I will address it in next revision.


>
> > +			dev_dbg(dev, "failed to attach pm domain %d, ret=%ld\n", i,
> > +				PTR_ERR(r5_core->pm_dev_core0[i]));
> > +			ret = -EINVAL;
> > +			goto fail_add_pm_domains;
> > +		}
> > +		r5_core->pm_dev_core0_link[i] = device_link_add(dev,
> > +								r5_core->pm_dev_core0[i],
> > +								DL_FLAG_STATELESS |
> > +								DL_FLAG_RPM_ACTIVE |
> > +								DL_FLAG_PM_RUNTIME);
> > +		if (!r5_core->pm_dev_core0_link[i]) {
> > +			dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > +			r5_core->pm_dev_core0[i] = NULL;
> > +			ret = -EINVAL;
> > +			goto fail_add_pm_domains;
> > +		}
> > +	}
> > +
> > +	if (cluster->mode == SPLIT_MODE)
> > +		return 0;
> > +
> > +	r5_core->pm_dev_core1 = kcalloc(num_pm_dev,
> > +					sizeof(struct device *),
> > +					GFP_KERNEL);
> > +	if (!r5_core->pm_dev_core1) {
> > +		ret = -ENOMEM;
> > +		goto fail_add_pm_domains;
> > +	}
> > +
> > +	r5_core->pm_dev_core1_link = kcalloc(num_pm_dev,
> > +					     sizeof(struct device_link *),
> > +					     GFP_KERNEL);
> > +	if (!r5_core->pm_dev_core1_link) {
> > +		kfree(r5_core->pm_dev_core1);
> > +		r5_core->pm_dev_core1 = NULL;
> > +		ret = -ENOMEM;
> > +		goto fail_add_pm_domains;
> > +	}
> > +
> > +	/* get second core's device to detach its power-domains */
> > +	np = of_get_next_child(cluster->dev->of_node, of_node_get(dev->of_node));
> > +
> > +	pdev = of_find_device_by_node(np);
> > +	if (!pdev) {
> > +		dev_err(cluster->dev, "core1 platform device not available\n");
> > +		kfree(r5_core->pm_dev_core1);
> > +		kfree(r5_core->pm_dev_core1_link);
> > +		r5_core->pm_dev_core1 = NULL;
> > +		r5_core->pm_dev_core1_link = NULL;
> > +		ret = -EINVAL;
> > +		goto fail_add_pm_domains;
> > +	}
> > +
> > +	dev2 = &pdev->dev;
> > +
> > +	/* for zynqmp we only add TCM power domains and not core's power domain */
> > +	for (j = 1; j < r5_core->num_pm_dev; j++) {
> > +		r5_core->pm_dev_core1[j] = dev_pm_domain_attach_by_id(dev2, j);
> > +		if (!r5_core->pm_dev_core1[j]) {
> > +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > +			ret = -EINVAL;
> > +			goto fail_add_pm_domains_lockstep;
> > +		} else if (IS_ERR(r5_core->pm_dev_core1[j])) {
> > +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > +			ret = PTR_ERR(r5_core->pm_dev_core1[j]);
> > +			goto fail_add_pm_domains_lockstep;
> > +		}
> > +
> > +		r5_core->pm_dev_core1_link[j] = device_link_add(dev,
> > +								r5_core->pm_dev_core1[j],
> > +								DL_FLAG_STATELESS |
> > +								DL_FLAG_RPM_ACTIVE |
> > +								DL_FLAG_PM_RUNTIME);
> > +		if (!r5_core->pm_dev_core1_link[j]) {
> > +			dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > +			r5_core->pm_dev_core1[j] = NULL;
> > +			ret = -ENODEV;
> > +			goto fail_add_pm_domains_lockstep;
> > +		}
> > +	}
> > +
> > +fail_add_pm_domains_lockstep:
> > +	while (--j >= 0) {
> > +		device_link_del(r5_core->pm_dev_core1_link[j]);
> > +		dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > +	}
> > +	kfree(r5_core->pm_dev_core1);
> > +	r5_core->pm_dev_core1 = NULL;
> > +	kfree(r5_core->pm_dev_core1_link);
> > +	r5_core->pm_dev_core1_link = NULL;
> > +
> > +fail_add_pm_domains:
> > +	while (--i >= 0) {
> > +		device_link_del(r5_core->pm_dev_core0_link[i]);
> > +		dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > +	}
> > +	kfree(r5_core->pm_dev_core0);
> > +	r5_core->pm_dev_core0 = NULL;
> > +	kfree(r5_core->pm_dev_core0_link);
> > +	r5_core->pm_dev_core0_link = NULL;
> > +
>
> The error path is much cleaner and readable now.
>
> I will continue tomorrow.
>
> Mathieu
>
> > +	return ret;
> > +}
> > +
> >  /**
> >   * zynqmp_r5_rproc_prepare()
> >   * adds carveouts for TCM bank and reserved memory regions
> > @@ -770,19 +966,30 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> >  {
> >  	int ret;
> >  
> > +	ret = zynqmp_r5_add_pm_domains(rproc);
> > +	if (ret) {
> > +		dev_err(&rproc->dev, "failed to add pm domains\n");
> > +		return ret;
> > +	}
> > +
> >  	ret = add_tcm_banks(rproc);
> >  	if (ret) {
> >  		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
> > -		return ret;
> > +		goto fail_prepare;
> >  	}
> >  
> >  	ret = add_mem_regions_carveout(rproc);
> >  	if (ret) {
> >  		dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
> > -		return ret;
> > +		goto fail_prepare;
> >  	}
> >  
> >  	return 0;
> > +
> > +fail_prepare:
> > +	zynqmp_r5_remove_pm_domains(rproc);
> > +
> > +	return ret;
> >  }
> >  
> >  /**
> > @@ -801,6 +1008,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> >  
> >  	r5_core = rproc->priv;
> >  
> > +	zynqmp_r5_remove_pm_domains(rproc);
> > +
> >  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
> >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> >  		if (zynqmp_pm_release_node(pm_domain_id))
> > -- 
> > 2.25.1
> > 
