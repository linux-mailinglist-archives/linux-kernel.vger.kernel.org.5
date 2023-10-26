Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB84A7D8644
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345601AbjJZPvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345555AbjJZPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:51:08 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018711AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTF3EiAeDN/HyodSoS+mOmnKtDXFEzDXrTUqaXjF+N6oRR+6OW20P4EZpgtmkDEmTGM5yzoe5HtU/cnWCx1El+uHm6R2+wZ7/wt+Sn10vtD+7FpX+mZRbKaqlR/rHlIi5blntvk3MSLi1Icr0h+o/6VEFJ7QDLU86Pn3ZN0/PNAYpfxrpVr6FCQ3dBFBo1bpprV5YEtElgrcwuVeCLIKF2Zrb+CL5KXdzVOvdjDbUWDWrBfH6NZKZjaj9idxXSEw+XfQXHQZozUetuBPUzmpkUNna0MGGYorrSbOAYYqyTtssvV2OFJuVtABcBwcg2L8CuwEvdOOd2ApdVfBH+TnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21+et3JZBDEvriQeNKmwtENs3jf7lQrD2SJbUlF6Sl4=;
 b=hD6nzWbWp2Hp7CPPSeA7XI7lV+y6M5hVsYAolFZqnoHG0PQ75ITcZt5U/F5+h2s2KUHOvxVHxMlZQEb++67LCX0t0J6CZUaSCPvfR1rNrv79O8gWJgHziiPMzSTHRknCRBQkwTgTmx7nI9aUh7S1oLHXVfLNccxZFSxAb/bK2lpg4NzrGKjKFNFhZvqHylGN0VmqBOb5CsAwC2LlvLnqiYO2M0EJmHJMzVEOw83DY484tT5qQ+jpeLqd/IMJoImTXjNA45d7A09pNPnQ/cCdHMHBZG3foISqoNo8EyZsuD2L++LMqOXjCeIwU/YebqXKRZSIly3mno4lDHjZm2YUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21+et3JZBDEvriQeNKmwtENs3jf7lQrD2SJbUlF6Sl4=;
 b=V9utLJjshTqOlNPSybqHmv9Rt1PjLpEAT1vk9UQTPbxp+Ag4L9URA1+rUk8Mlp3P8xAzEHu2a49YNIhwM2y+ARGMAHCN5l3WLCNbdY/m3IWFa3BxToR81dtYl6SGCYLhefrrcf4pEq87c+3l0H9HQoY0pMuEjnx3bNpBtmGu2lE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DS0PR08MB9164.namprd08.prod.outlook.com
 (2603:10b6:8:1b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 15:50:58 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 15:50:58 +0000
Date:   Thu, 26 Oct 2023 10:50:55 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: drivers/input/misc/iqs626a.c:780:61: warning: '%d' directive
 output may be truncated writing between 1 and 10 bytes into a region of size
 2
Message-ID: <ZTqK37deBniFVnWT@nixie71>
References: <202310190041.28bxUK0W-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310190041.28bxUK0W-lkp@intel.com>
X-ClientProxiedBy: SN7PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:806:f3::13) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DS0PR08MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c583a3-35aa-43e1-f163-08dbd63b58ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYhCNhXAtWM4Rz4efgXNHlBRx1xPi6Px7/W1I0KCEBK5Wgrltcg0ndgO+RmSTX5eUFbAJ5afe9mfcRog+cNL7bcfVuLflHrN67TboEgjA37tSydDf+GPo7Cu/yrpNm5g5gs0oSK2QGWLeWpD6p5qOiPwEb1j3BzoRLDbRwWKN6r/J0iuya7ISqsSuhA4vaxzqx6x5R9MJiPTIvDbBcotKNfDLbSLc4bwVeEY+YqVhkGpLu/RzysjribFm2SAPApFCvoCAAeROe5lnvAg3I2Wd/O+xXpR+HH/uEK1MprEAfqEC9N7d5hNDIHSuzJyl0cMWR/tai4ewrlgAI5U4hgV6gbUIKLQEFFNRlL9KyxfI5KVUu5RteyzIu1v5tF2i+K8yzhLBc2f+L/bX5KiXjqVL/AwSqy+uwqtytY01LgexYhBvxo9RrTeJR82RWF9babhil8WqauyWegflekIkQom8OcV1nuIdZ59YKDh+/s1Ci8awLqYkus3oSx8ddGOV37fqRop7BeelqqzFTg6RGGt8EN9sknrK1Oc758mB4aYtO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(39830400003)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(33716001)(2906002)(4326008)(41300700001)(8676002)(5660300002)(86362001)(8936002)(6506007)(66476007)(38100700002)(6916009)(66946007)(478600001)(316002)(83380400001)(6666004)(6512007)(966005)(66556008)(6486002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?33z8sGwhHCV/CCTV/zViKo9X0QRhsTJfghB2vL5ZlruAtF90Ts2QceEeuxlP?=
 =?us-ascii?Q?zz4jgkqndDL/OTnDnXXzicuSQYTKa/kw7foSksqIa9NBhd4ZekS0Gd6aphXu?=
 =?us-ascii?Q?L+YpZsABH7azE0ud7NXV7ce9E3+F6bHQcy+eYKy3yDKnj9A/xj13/E9maMu/?=
 =?us-ascii?Q?p92JpNZ7QtnYgvG9y8HFeG9ZLxBD16col+km+YQ+awSE0yGTOz8O6wDgyIco?=
 =?us-ascii?Q?pJ/OQCEjIsnHNUxWmq/rxMASsxpekdDd8zFANHw7ZOKZH+C9hBZpK8WIyio8?=
 =?us-ascii?Q?QUQAlYjrwk9YMTab0aoLIUYi0d5x3W2rOejv2FiOd11uyLv0gZdChiIL0U3K?=
 =?us-ascii?Q?h4xuNoSylKf4xz1ENNrMZvykHOecA56f8NIjUWBf+viClro9uCKpi8qUIzGY?=
 =?us-ascii?Q?xrqG2GakW6GT17Vt/Joc0qOa6Dfswf1J6ORJdsxMjVYaH9qpLRUb0YWIhKr8?=
 =?us-ascii?Q?x5sxAbw3X6udWuTHVkoApiVBUXU3rZS57zMzDM7gsY7Al/YvrfyX3tzHztTC?=
 =?us-ascii?Q?6Ala1kPewnAx8MQb3bu5GQ3LTthqT7+cLBs1r9+McZcMmS1zZpx+pUwfE9VV?=
 =?us-ascii?Q?CHc74MY/vxvAuMNJprmRKAJEw0FMxQgb4glUKcyiWvgLDOrGfn7ZIRVb5Zft?=
 =?us-ascii?Q?N1La6Le6FBfNYGd6KWKK8vGRywjM/VF352yLyhSeEqbeplbt2tEGHWRh8fZ2?=
 =?us-ascii?Q?MvjGUI9MvrnBDKSV5ETy5cBrVYKfXj5+34rIvmUmvDEC/kJeGXi+U/UeZPiG?=
 =?us-ascii?Q?9708Ft6ks1fWKut/ztICHmawffXUF/xv5pPVhUtpzMor3xCFLmjb3nnFxffe?=
 =?us-ascii?Q?BaDyNxfSTN7D/7aTFHU6frpbVO16OQB7CgHivPISQyhfFOm0IZXWrswH+HsL?=
 =?us-ascii?Q?16se/S9gFEp76Hs+wMtNT+Rk4w24UiXgBTh0XiOo1iOH6Ua3e/i18ZcjizdK?=
 =?us-ascii?Q?k6XIRhRt5BAaEuPlUEH6WeKr2hKVY1RQbOnVruYxtQ3TV5hjQ90uqhxdCwIT?=
 =?us-ascii?Q?JvWQDed6JbCNfHVOgONOOzXDZqMhi+47X8RGR1s+4AEFF11eWD/FaPxhsbBz?=
 =?us-ascii?Q?GbB7CySxDZ5kZvCUkzRz5/YoUgrgC2EMWsR591H/Qk8JH3lm9wgGLxEyxnYV?=
 =?us-ascii?Q?UQaKgpfKQRiGyqWX120Ocahe38ZWt6vLYGuZdasDHscEiUsRgtN4LNrtD5N/?=
 =?us-ascii?Q?5RE4SxyX9jQBSqsB9K29Yy/Zuw4dCyU92Mje1AMo4rVGZJSil8h/P9be8Pv/?=
 =?us-ascii?Q?An/cJIp8SecXiZfY6gEd3o+tUPsdjRMF6mNafA/Zp6YBKOtZSNUU32zDuvuO?=
 =?us-ascii?Q?gk2YDIzblyjKNawvWJub9MYgDTTgEjG8SkVWeiARECLrAcA6J2qhmJJ4J4Rf?=
 =?us-ascii?Q?wM+C1WyuaXL1eExZlwJGecgdp8kq7xZDW93rAIU0k/38pGMViHEVhNSmhITM?=
 =?us-ascii?Q?g1pdWwEtRSw4G+hA6b36cxAEPAhVp5ko2i5Ivg/lMqzG06a7H21/znO87JZo?=
 =?us-ascii?Q?VlGTOtsXnCRvESVHYTRoelsG4AW07Q8T4Q5pyXu1xvUrDR6ZUnnQn9UM+Axb?=
 =?us-ascii?Q?NIHaZt2ks/P44EToTfKmemFcM0lhKaQIixW4N2dr?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c583a3-35aa-43e1-f163-08dbd63b58ad
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 15:50:58.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aps75YlQcM+XJ5zJ4g9YVE1mYHZkHE9jCDWbbrQuWJDgZ+EnOTckjjHEEfpG4cd/kZvDvbOf6rqJzy80yw34g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR08MB9164
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps the list can let me know if I am missing anything...

On Thu, Oct 19, 2023 at 12:34:52AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
> commit: 4d3d2694e168c542b088eef5059d31498f679020 Input: iqs626a - drop unused device node references
> date:   9 months ago
> config: x86_64-randconfig-r015-20230901 (https://download.01.org/0day-ci/archive/20231019/202310190041.28bxUK0W-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310190041.28bxUK0W-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310190041.28bxUK0W-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/input/misc/iqs626a.c: In function 'iqs626_parse_trackpad':
> >> drivers/input/misc/iqs626a.c:780:61: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
>      780 |                 snprintf(tc_name, sizeof(tc_name), "channel-%d", i);
>          |                                                             ^~
>    drivers/input/misc/iqs626a.c:780:52: note: directive argument in the range [0, 2147483646]
>      780 |                 snprintf(tc_name, sizeof(tc_name), "channel-%d", i);
>          |                                                    ^~~~~~~~~~~~
>    drivers/input/misc/iqs626a.c:780:17: note: 'snprintf' output between 10 and 19 bytes into a destination of size 10
>      780 |                 snprintf(tc_name, sizeof(tc_name), "channel-%d", i);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This cannot actually happen during runtime; 'i' is limited to at most 8. The
warning seems bogus.

> 
> 
> vim +780 drivers/input/misc/iqs626a.c
> 
>    712	
>    713	static int iqs626_parse_trackpad(struct iqs626_private *iqs626,
>    714					 struct fwnode_handle *ch_node,
>    715					 enum iqs626_ch_id ch_id)
>    716	{
>    717		struct iqs626_sys_reg *sys_reg = &iqs626->sys_reg;
>    718		struct i2c_client *client = iqs626->client;
>    719		u8 *hyst = &sys_reg->tp_grp_reg.hyst;
>    720		int error, count, i;
>    721		unsigned int val;
>    722	
>    723		if (!fwnode_property_read_u32(ch_node, "azoteq,lta-update", &val)) {
>    724			if (val > IQS626_MISC_A_TPx_LTA_UPDATE_MAX) {
>    725				dev_err(&client->dev,
>    726					"Invalid %s channel update rate: %u\n",
>    727					fwnode_get_name(ch_node), val);
>    728				return -EINVAL;
>    729			}
>    730	
>    731			sys_reg->misc_a &= ~IQS626_MISC_A_TPx_LTA_UPDATE_MASK;
>    732			sys_reg->misc_a |= (val << IQS626_MISC_A_TPx_LTA_UPDATE_SHIFT);
>    733		}
>    734	
>    735		if (!fwnode_property_read_u32(ch_node, "azoteq,filt-str-trackpad",
>    736					      &val)) {
>    737			if (val > IQS626_FILT_STR_MAX) {
>    738				dev_err(&client->dev,
>    739					"Invalid %s channel filter strength: %u\n",
>    740					fwnode_get_name(ch_node), val);
>    741				return -EINVAL;
>    742			}
>    743	
>    744			sys_reg->misc_b &= ~IQS626_MISC_B_FILT_STR_TPx;
>    745			sys_reg->misc_b |= val;
>    746		}
>    747	
>    748		if (!fwnode_property_read_u32(ch_node, "azoteq,filt-str-np-cnt",
>    749					      &val)) {
>    750			if (val > IQS626_FILT_STR_MAX) {
>    751				dev_err(&client->dev,
>    752					"Invalid %s channel filter strength: %u\n",
>    753					fwnode_get_name(ch_node), val);
>    754				return -EINVAL;
>    755			}
>    756	
>    757			*hyst &= ~IQS626_FILT_STR_NP_TPx_MASK;
>    758			*hyst |= (val << IQS626_FILT_STR_NP_TPx_SHIFT);
>    759		}
>    760	
>    761		if (!fwnode_property_read_u32(ch_node, "azoteq,filt-str-lp-cnt",
>    762					      &val)) {
>    763			if (val > IQS626_FILT_STR_MAX) {
>    764				dev_err(&client->dev,
>    765					"Invalid %s channel filter strength: %u\n",
>    766					fwnode_get_name(ch_node), val);
>    767				return -EINVAL;
>    768			}
>    769	
>    770			*hyst &= ~IQS626_FILT_STR_LP_TPx_MASK;
>    771			*hyst |= (val << IQS626_FILT_STR_LP_TPx_SHIFT);
>    772		}
>    773	
>    774		for (i = 0; i < iqs626_channels[ch_id].num_ch; i++) {
>    775			u8 *ati_base = &sys_reg->tp_grp_reg.ch_reg_tp[i].ati_base;
>    776			u8 *thresh = &sys_reg->tp_grp_reg.ch_reg_tp[i].thresh;
>    777			struct fwnode_handle *tc_node;
>    778			char tc_name[10];
>    779	
>  > 780			snprintf(tc_name, sizeof(tc_name), "channel-%d", i);
>    781	
>    782			tc_node = fwnode_get_named_child_node(ch_node, tc_name);
>    783			if (!tc_node)
>    784				continue;
>    785	
>    786			if (!fwnode_property_read_u32(tc_node, "azoteq,ati-base",
>    787						      &val)) {
>    788				if (val < IQS626_TPx_ATI_BASE_MIN ||
>    789				    val > IQS626_TPx_ATI_BASE_MAX) {
>    790					dev_err(&client->dev,
>    791						"Invalid %s %s ATI base: %u\n",
>    792						fwnode_get_name(ch_node), tc_name, val);
>    793					fwnode_handle_put(tc_node);
>    794					return -EINVAL;
>    795				}
>    796	
>    797				*ati_base = val - IQS626_TPx_ATI_BASE_MIN;
>    798			}
>    799	
>    800			if (!fwnode_property_read_u32(tc_node, "azoteq,thresh",
>    801						      &val)) {
>    802				if (val > IQS626_CHx_THRESH_MAX) {
>    803					dev_err(&client->dev,
>    804						"Invalid %s %s threshold: %u\n",
>    805						fwnode_get_name(ch_node), tc_name, val);
>    806					fwnode_handle_put(tc_node);
>    807					return -EINVAL;
>    808				}
>    809	
>    810				*thresh = val;
>    811			}
>    812	
>    813			fwnode_handle_put(tc_node);
>    814		}
>    815	
>    816		if (!fwnode_property_present(ch_node, "linux,keycodes"))
>    817			return 0;
>    818	
>    819		count = fwnode_property_count_u32(ch_node, "linux,keycodes");
>    820		if (count > IQS626_NUM_GESTURES) {
>    821			dev_err(&client->dev, "Too many keycodes present\n");
>    822			return -EINVAL;
>    823		} else if (count < 0) {
>    824			dev_err(&client->dev, "Failed to count keycodes: %d\n", count);
>    825			return count;
>    826		}
>    827	
>    828		error = fwnode_property_read_u32_array(ch_node, "linux,keycodes",
>    829						       iqs626->tp_code, count);
>    830		if (error) {
>    831			dev_err(&client->dev, "Failed to read keycodes: %d\n", error);
>    832			return error;
>    833		}
>    834	
>    835		sys_reg->misc_b &= ~IQS626_MISC_B_TPx_SWIPE;
>    836		if (fwnode_property_present(ch_node, "azoteq,gesture-swipe"))
>    837			sys_reg->misc_b |= IQS626_MISC_B_TPx_SWIPE;
>    838	
>    839		if (!fwnode_property_read_u32(ch_node, "azoteq,timeout-tap-ms",
>    840					      &val)) {
>    841			if (val > IQS626_TIMEOUT_TAP_MS_MAX) {
>    842				dev_err(&client->dev,
>    843					"Invalid %s channel timeout: %u\n",
>    844					fwnode_get_name(ch_node), val);
>    845				return -EINVAL;
>    846			}
>    847	
>    848			sys_reg->timeout_tap = val / 16;
>    849		}
>    850	
>    851		if (!fwnode_property_read_u32(ch_node, "azoteq,timeout-swipe-ms",
>    852					      &val)) {
>    853			if (val > IQS626_TIMEOUT_SWIPE_MS_MAX) {
>    854				dev_err(&client->dev,
>    855					"Invalid %s channel timeout: %u\n",
>    856					fwnode_get_name(ch_node), val);
>    857				return -EINVAL;
>    858			}
>    859	
>    860			sys_reg->timeout_swipe = val / 16;
>    861		}
>    862	
>    863		if (!fwnode_property_read_u32(ch_node, "azoteq,thresh-swipe",
>    864					      &val)) {
>    865			if (val > IQS626_THRESH_SWIPE_MAX) {
>    866				dev_err(&client->dev,
>    867					"Invalid %s channel threshold: %u\n",
>    868					fwnode_get_name(ch_node), val);
>    869				return -EINVAL;
>    870			}
>    871	
>    872			sys_reg->thresh_swipe = val;
>    873		}
>    874	
>    875		sys_reg->event_mask &= ~IQS626_EVENT_MASK_GESTURE;
>    876	
>    877		return 0;
>    878	}
>    879	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Kind regards,
Jeff LaBundy
