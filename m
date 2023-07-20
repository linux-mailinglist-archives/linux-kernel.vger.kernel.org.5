Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A06F75B67B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGTST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjGTSTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:19:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2095.outbound.protection.outlook.com [40.107.243.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0912D40;
        Thu, 20 Jul 2023 11:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjwqDMV72pzvfm7aDhp58lu25Vt/khHG512if65YAZTimAOT+q0v2QS0HnBoeMe5RxUnZwIxEfCqg7S0QsKP3VxKvf718dexR6mA9gXJuYCCelC8eQ34RK7hQxOhf6sGJ62SKWD37k7Jlo5CvU9OWo3UR14TPxlTRZI1e/hWG3j1x9N9sapbwVdRix0tzKKDhGL0wzaWHewkjLVPZFcDOhyxyhQfF0ByctDAopurg+NVIRfk/GGlWvcj3IIX3ga0pF6OGCcDW+v1MFHVHvXTWITMC49gCbRGvmW2Nztdq4iPjiB5Tb89ZJd/UqIUtfMTWYVxfWD6lKoF6B2HZ4t7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaR8rJCQA5TUOOuZQFIXz8CJ1lqGguNQsOTOy1MMFB8=;
 b=XZ084WZc/zMGIZo+ApWHsi/V/S7O1KMTfQa5MuVOP7nda+DSd7p3N5E+zFBJPRgZKzsEz1XCVlwbMwrRmadZKde0WGbQWyqQTbongP7vaczTExj7Rp6ZAVMI/0k3tziOFCByFKYPak35GNPz3lgopG6kLFgpQGQNeOQATt8K1sPiHt5rvpJVb+M/mUy18OEchD7o+GTZ45MKeM8yy6ACUo8VFtoB2OE6KkL++Mp/Q8J/WihvLxaAS8qPlEa7VVIfodu6Yp/eHhEUfYa/VDGy0wEiu7kRFbfQIwROsjLjQCzZpjT/TEU2F5S+WDztLgWMda2dPybfVjXLsOYiJrAQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaR8rJCQA5TUOOuZQFIXz8CJ1lqGguNQsOTOy1MMFB8=;
 b=BxQDwRmCInHTboBx52SDzOPINLJfkMqUQsZqp5CVk9QEpN4KzMlLZtixaeFPbqi7fFtj+B3uRWJxN0/MRTKnZOG0Gk9eRnUN+CESgtWjoG9nqQThUF0Bq4tKJWxGUAatVcXNOeYN1NfrPdh5VPR3zUPSC2TDfJiPF34etUVu9Rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB3617.namprd13.prod.outlook.com (2603:10b6:a03:21b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 18:19:13 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 18:19:13 +0000
Date:   Thu, 20 Jul 2023 19:19:04 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 1/1] net: dsa: microchip: Add partial ACL
 support for ksz9477 switches
Message-ID: <ZLl6mF8iKBD/OeHb@corigine.com>
References: <20230719111930.515070-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719111930.515070-1-o.rempel@pengutronix.de>
X-ClientProxiedBy: LO4P123CA0395.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB3617:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c49f2e-9014-4c71-cc4c-08db894dd1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: valxGXFU5vNQNTSYCjPLsA8923Ag5Dq9z4ehsDpVXuzvPwJa/4UJsOBXZbD3jyB7TlGfRen8XzORYSJ0mmU2RsGHKla+6PZXw2TA7MMmx0ZghDnUf+kzdIvmoI1SBvTxmgTg6W7NhDEZ1RMpqeBZTP6wjRpSBZVzvr0lqbpmXHdxMkIYuhLzPeI9qw/KK8Xud4vBpE7dsytlTbzle5cLIM0w8pTqtkK1WyijaRBOlFzr5zAGxGLFd3AjGEtVZiSNnaIRhQpNOA8TXIgclbP09SrFgaLLgTe/W8++j+NlUx8KysgM2BU8JpwBwffQSmpUc7hkZZWbdQhyle3uPVhAlSlwIgZhWTojolQOt+Q4y/1t3jTUg1D12OkAE5/f/TBoqfYY34RqF7fDZ95Q53WfSbi22FEjl2R2LK8MSGFjtER5ExFgKvRsfSk+xULS2A5AAd366C97Ri3pSDBPLIDWw8v0mc12RoDO805XQ7rCSHe3Y4936jAPssMxFjkfogG4zJ7O1YIZ/uSSql6fkCPZH/eWgJkBWrMd60zUeBEIKY/fZ8mBmjRMs709lWzCbA6HRxfB17UiJez/VHFyvN9NSiZ+UWrIy+fxYg+vAh3Mjxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39830400003)(366004)(376002)(451199021)(6916009)(66476007)(26005)(55236004)(6506007)(4326008)(66946007)(478600001)(66556008)(54906003)(6486002)(6666004)(36756003)(86362001)(83380400001)(186003)(2616005)(316002)(8676002)(5660300002)(41300700001)(44832011)(6512007)(2906002)(8936002)(38100700002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xs6MIFLC4PS9ySRFdonrXT5YFbUVtY5ZuS5sxnhNNfOxF9ri3Rsyc4v6GqxB?=
 =?us-ascii?Q?/yIfCjvsycIAMm9D5WMFhQo8RTljGipQJs0ZEo/DAjFmkIErF53F8DxP7QWo?=
 =?us-ascii?Q?jIDdps6epiXmAXIqi0uD+bnxBN2HrRDJxRSINd1Qbvx2TO8ReqUPF3iuDwJ/?=
 =?us-ascii?Q?prHCBWjxOXfCNwYvv6kAXPlE4aKNU1Cbrhj/if7jP7pXA4XwvGTYjsjq4ca1?=
 =?us-ascii?Q?rU52SeWHsXEgqw4v64sz4ytxGaHXt6aN+/9j4czkfngRbbweAFZREtoisfZ8?=
 =?us-ascii?Q?RUYvPAjWpyYn/YbzfCCQe8Ll3ICOecVtMLRtfn7tEsqhp6KyP7F1UXFI1nPx?=
 =?us-ascii?Q?rq1W7D7YRDjst8ZNJm0D2DbmfPz9SZAyYYzZyYVaoMWbdvsbqBWDL0+gDUCY?=
 =?us-ascii?Q?RAH4OfnsbtcUgSK5kZHFugY/La0vOo40a1YnkvFY67ujgzB5Dmf+MPZ6qZns?=
 =?us-ascii?Q?zolRJiZ4L+KhtNv+N4ipz2lQwT6M2oZvAjApw84bBlsFxaTwaEnss1T/UiQO?=
 =?us-ascii?Q?ed2bywgrCwcq4h1QLH1+wevxG6A75gjB0yItdgme5Xol/BI1SDehWztyLU4g?=
 =?us-ascii?Q?eisPErfPHUHSWvPCTN/7+W0NzWo21Dz6QZLve1aFhy+59RT3GxgIe7nArWs1?=
 =?us-ascii?Q?d54s+8N9nErcpptD6Lr+nHtQbTAckWr041aarKOU1Mxfx3iddN89GuAlAidz?=
 =?us-ascii?Q?f/wUHQPF9RZ1ZgbJuZMr2XtDIbJGGQ4G+gEBwks2ID5zhHM+sqtfIwVs7cDN?=
 =?us-ascii?Q?dpWPzRYjARi0vy9dp0m3upcJ9mdNFsWAHpoGt/aEtZqE/E0Sc/cjcv/G+/mY?=
 =?us-ascii?Q?L6Kop9oRH+3qmd6FjZKB0UdHscQp4fgqkIiLdmotxBFJZTAPTcyfxfpt0Nlz?=
 =?us-ascii?Q?367vtd9ox2ltrG+v6MyAiHtgq6iSUN0QYzSYYqmhFKl8MgFFGSKc5RGi9piC?=
 =?us-ascii?Q?HYSZivYbdK+lPyac6eVjms8E+7NzFB4VLWiQnfe1IsG7mWAmuuiFhWFtCv2/?=
 =?us-ascii?Q?iqv4Z95qb8IwqQiudvIdvxfNDWoYosoDlpj+67fxzKiWa04faXf/JVvJJcZD?=
 =?us-ascii?Q?bUcdde3ER1HGFvwdK8gdcCsGCYewzsz+wqg0z+a1DQA6JGdWYvE+BLjlnTiu?=
 =?us-ascii?Q?eAyZDaMqVc0MCrCve9E0+xgekWu/Kzg5M29qu1okAKsio+c+dS7paw55CMlU?=
 =?us-ascii?Q?2CdcDPOjrDv2X6TJD8yWI2RU0sEpW/d4fweXk9u2t/b06HQEJcJ8q5sxvLCm?=
 =?us-ascii?Q?D7Ehr+cYTJ0Cscnx+pWXVej+BfXEop97rJaYlfimCWzbGo6RwjTMhCEN7Dnz?=
 =?us-ascii?Q?XPLWxWF62PZNAOZVdi00ixwqKZdV8UBxGyZho1r6rcnYmuQVumph9qFwzmyD?=
 =?us-ascii?Q?ECe8NT6jYmX5yzFHrLd+zEBKyx6hFvX4eKpaowm8/BiHy/PGVfn6WqHHBr88?=
 =?us-ascii?Q?B2XYZZvKYiqmXT0AcD3kX7Et1g+d136qcPRF3xPm/gKxK12M3I4lmDFd7f0f?=
 =?us-ascii?Q?XmIGSL6Rh5DW4jsNPah9/i3nD+tJSbwUFQ7KRDBRS7sd7vgfuVymgsNwVOgV?=
 =?us-ascii?Q?Yvi/RmdEpujOkPUnPEVLczJg12gJavqiZj50kC/RH98cC6/FsFX0IxIEF/hj?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c49f2e-9014-4c71-cc4c-08db894dd1f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 18:19:13.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poeMcFDkTim8C4uUy0P48mLSmUaOojiM/FalYsCGXVE0XLvsf9V2tngUAZavrCG2mcoQbUc4YzINCVFFIrLfv+HDNIaDBmlSRDdxknhFuBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3617
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 01:19:29PM +0200, Oleksij Rempel wrote:

...

Hi Oleksij,

> +/**
> + * ksz9477_acl_port_enable - Enables ACL functionality on a given port.
> + * @dev: The ksz_device instance.
> + * @port: The port number on which to enable ACL functionality.
> + *
> + * This function enables ACL functionality on the specified port by configuring
> + * the appropriate control registers. It returns 0 if the operation is
> + * successful, or a negative error code if an error occurs.
> + *
> + * 0xn801 - KSZ9477S 5.2.8.2 Port Priority Control Register
> + *        Bit 7 - Highest Priority
> + *        Bit 6 - OR'ed Priority
> + *        Bit 4 - MAC Address Priority Classification
> + *        Bit 3 - VLAN Priority Classification
> + *        Bit 2 - 802.1p Priority Classification
> + *        Bit 1 - Diffserv Priority Classification
> + *        Bit 0 - ACL Priority Classification
> + *
> + * Note: current driver implementation sets 802.1p priority classification
> + * by default. In this function we add ACL priority classification with OR'ed
> + * priority. According to testing, priority set by ACL will supersede the
> + * 802.1p priority.
> + *
> + * 0xn803 - KSZ9477S 5.2.8.4 Port Authentication Control Register
> + *        Bit 2 - Access Control List (ACL) Enable
> + *        Bits 1:0 - Authentication Mode
> + *                00 = Reserved
> + *                01 = Block Mode. Authentication is enabled. When ACL is
> + *                     enabled, all traffic that misses the ACL rules is
> + *                     blocked; otherwise ACL actions apply.
> + *                10 = Pass Mode. Authentication is disabled. When ACL is
> + *                     enabled, all traffic that misses the ACL rules is
> + *                     forwarded; otherwise ACL actions apply.
> + *                11 = Trap Mode. Authentication is enabled. All traffic is
> + *                     forwarded to the host port. When ACL is enabled, all
> + *                     traffic that misses the ACL rules is blocked; otherwise
> + *                     ACL actions apply.
> + *
> + * Note: we are using Pass Mode here.

kernel-doc gcc-12 W=1 and clang-16 W=1 all complains
that there is a duplicate Note section in the above.

...

> +/**
> + * ksz9477_acl_matching_rule_cfg_l2 - Configure an ACL filtering entry to match
> + *				      L2 types of Ethernet frames
> + * @entry: Pointer to ACL entry buffer
> + * @ethertype: Ethertype value
> + * @eth_addr: Pointer to Ethernet address
> + * @is_src: If true, match the source MAC address; if false, match the
> + *	    destination MAC address
> + *
> + * This function configures an Access Control List (ACL) filtering
> + * entry to match Layer 2 types of Ethernet frames based on the provided
> + * ethertype and Ethernet address. Additionally, it can match either the source
> + * or destination MAC address depending on the value of the is_src parameter.
> + *
> + * Register Descriptions for MD = 01 and ENB != 00 (Layer 2 MAC header
> + * filtering)
> + *
> + * 0x01 - Mode and Enable
> + *        Bits 5:4 - MD (Mode)
> + *                01 = Layer 2 MAC header or counter filtering
> + *        Bits 3:2 - ENB (Enable)
> + *                01 = Comparison is performed only on the TYPE value
> + *                10 = Comparison is performed only on the MAC Address value
> + *                11 = Both the MAC Address and TYPE are tested
> + *        Bit  1   - S/D (Source / Destination)
> + *                0 = Destination address
> + *                1 = Source address
> + *        Bit  0   - EQ (Equal / Not Equal)
> + *                0 = Not Equal produces true result
> + *                1 = Equal produces true result
> + *
> + * 0x02-0x07 - MAC Address
> + *        0x02 - MAC Address [47:40]
> + *        0x03 - MAC Address [39:32]
> + *        0x04 - MAC Address [31:24]
> + *        0x05 - MAC Address [23:16]
> + *        0x06 - MAC Address [15:8]
> + *        0x07 - MAC Address [7:0]
> + *
> + * 0x08-0x09 - EtherType
> + *        0x08 - EtherType [15:8]
> + *        0x09 - EtherType [7:0]
> + */
> +static void ksz9477_acl_matching_rule_cfg_l2(u8 *entry, __be16 ethertype,
> +					     u8 *eth_addr, bool is_src)
> +{
> +	u8 enb = 0;
> +	u8 val;
> +
> +	if (ethertype)
> +		enb |= KSZ9477_ACL_ENB_L2_TYPE;
> +	if (eth_addr)
> +		enb |= KSZ9477_ACL_ENB_L2_MAC;
> +
> +	val = FIELD_PREP(KSZ9477_ACL_MD_MASK, KSZ9477_ACL_MD_L2_MAC) |
> +	      FIELD_PREP(KSZ9477_ACL_ENB_MASK, enb) |
> +	      FIELD_PREP(KSZ9477_ACL_SD_SRC, is_src) | KSZ9477_ACL_EQ_EQUAL;
> +	ksz9477_acl_set_reg(entry, KSZ9477_ACL_PORT_ACCESS_1, val);
> +
> +	if (eth_addr) {
> +		int i;
> +
> +		for (i = 0; i < ETH_ALEN; i++) {
> +			ksz9477_acl_set_reg(entry,
> +					    KSZ9477_ACL_PORT_ACCESS_2 + i,
> +					    eth_addr[i]);
> +		}
> +	}
> +
> +	ksz9477_acl_set_reg(entry, KSZ9477_ACL_PORT_ACCESS_8, ethertype & 0xff);
> +	ksz9477_acl_set_reg(entry, KSZ9477_ACL_PORT_ACCESS_9, ethertype >> 8);

ethertype is big endian.
But host byte order math is done on it in the two lines above.
This doesn't seem right.

...

> +/**
> + * ksz9477_flower_parse_action - Parse flow rule actions for a specified port
> + *				 on a ksz_device.
> + * @dev: The ksz_device instance.
> + * @port: The port number to parse the flow rule actions for.
> + * @extack: The netlink extended ACK for reporting errors.
> + * @cls: The flow_cls_offload instance containing the flow rule.
> + * @entry_idx: The index of the ACL entry to store the action.
> + *
> + * This function checks if the actions in the flow rule are supported by
> + * the device. Currently, only actions that change priorities are supported.
> + * If unsupported actions are encountered, an error message is set in the
> + * extended ACK.
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +static int ksz9477_flower_parse_action(struct ksz_device *dev, int port,
> +				       struct netlink_ext_ack *extack,
> +				       struct flow_cls_offload *cls,
> +				       int entry_idx)
> +{
> +	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
> +	struct ksz9477_acl_priv *acl = dev->ports[port].acl_priv;
> +	const struct flow_action_entry *act;
> +	struct ksz9477_acl_entry *entry;
> +	bool prio_force = false;
> +	u8 prio_val;
> +	int i;
> +
> +	if (TC_H_MIN(cls->classid)) {
> +		NL_SET_ERR_MSG_MOD(extack, "hw_tc is not supported. Use: action skbedit prio");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	flow_action_for_each(i, act, &rule->action) {
> +		switch (act->id) {
> +		case FLOW_ACTION_PRIORITY:
> +			if (act->priority > KSZ9477_MAX_TC) {
> +				NL_SET_ERR_MSG_MOD(extack, "Priority value is too high");
> +				return -EOPNOTSUPP;
> +			}
> +			prio_force = true;
> +			prio_val = act->priority;
> +			break;
> +		default:
> +			NL_SET_ERR_MSG_MOD(extack, "action not supported");
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	/* pick entry to store action */
> +	entry = &acl->acles.entries[entry_idx];
> +
> +	ksz9477_acl_action_rule_cfg(entry->entry, prio_force, prio_val);

If the flow_action_for_each loop iterates zero times then
prio_val will be uninitialised here. gcc-12 [-Wmaybe-uninitialized]
and Smatch warn about this. But I'm unsure if it can actually happen.

> +	ksz9477_acl_processing_rule_set_action(entry->entry, entry_idx);
> +
> +	return 0;
> +}

...
