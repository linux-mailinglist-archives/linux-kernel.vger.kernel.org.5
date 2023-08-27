Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DB078A0DD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjH0SEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjH0SET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:04:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2082a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F81132
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 11:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPapqjxNBptn9WzsT99ac+6xYNRXCf7bPoQRXOlqgmi3KP5KjMng0NJcegGW6zSWXc1fSYVK7EBDbe3vsruTOgHrvpAlR9xsf/b+5QJ21ZseKB5YCQHliXSyd2d86EJfm0dLnuWIZgA+o8AyzmhnbfPtKkKSiIU4BBq2msDYj/WM7ryR8ekeJjG18mEdSdMKvg3IJTh4l5jO3v1LPeMthmY8Xo5bvR6snqWF2bnSF2jQCWy0Q3lto8Y15mzbYIhDtOaC4RCBI9ktKUeusTyT1MIfxFp3giKGHAAXqEU2wrZ9tE0UA+VqrMm8FyMvRslSkIn+AbycH9n2rQOcqRqJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLIHNJXSZslqm7A3BWYtXpVft5+vy4/T9DOZwNNcoS4=;
 b=TFd2V3sFF8z4GLRix4UPuB8aAYtlQDF1rXAwA/Rrbp9x/MA4wz1fYAs+5SNXywHJRFmT0ewxsD3vI8UTr9R/iDbH7dRCPkF0d7bxyu3t5EFM1h+AL5gYexrzXAt2LTImbx3ifH7at1xpvLNqV3TUvGH3lyBin1p1n9IanmQPWrjvK5Bsr3oFaH7SHK+aBJXpVtewA/erUg5hjQkkuJMwtvhLPWDbx3RPxcDOSQ9KSfHUOBKAOuibLluDmsm+jSMSFUODUPGxxSZgd21AqFBInAeiirZk8Fd+hQOUFyYUYzbH30X/JP8qnWYtntLZ8IjaMMER6zcK2cdYMYbw50Kysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLIHNJXSZslqm7A3BWYtXpVft5+vy4/T9DOZwNNcoS4=;
 b=GqJU+X4LzOZbJIsyWfxWQxU8ptyJdWkOaluo2ubrXWOUOaVUEV85GmKojr/turxNvWRbRjYO36y8ofH9YnfmLA9fje/4MNFixGR164+WeJHe3vdkK5/V84aLFB2PFTSmry7GMDXjC3WdfNlPI19S5Ynr7R7LWRAJCiFAjQu5fXtjMoZkSy2F5B0B9VsM7JWhsPCeSsgj6UaQCZkQYifU2SU2iakoaRziPJRvSMYPDn1eXDUq3ts4/tJLwKysOoLR8g+zSx5PChRaVJOyqpHV1KZNvqc8JrRArDbszAAygT8U4a5BWUG2VgJrEJC46rhI1LFXFOQ7sBHAbjymCNWf9Q==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by LV8PR11MB8746.namprd11.prod.outlook.com (2603:10b6:408:202::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 17:59:04 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 17:59:04 +0000
Date:   Sun, 27 Aug 2023 13:59:00 -0400
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: octeon: clean up octeon ethernet driver
Message-ID: <PH7PR11MB76437D43414E0D5F2D579219BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
References: <PH7PR11MB7643572E8C1231C013762613BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
 <2023082744-alike-spendable-5b87@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082744-alike-spendable-5b87@gregkh>
From:   <ozlinux@hotmail.com>
X-TMN:  [sMdNBK3+TFS4U8D9ee3Yk5h0kjq59GNK49TEwJwf8XabLtnpXKMadWKq1APonzHb]
X-ClientProxiedBy: BL1PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::25) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <qsk62wpnaistt6hjrye6doge5idtbz76b7sevbembuw6wfhxqc@fui7xgofqs5f>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|LV8PR11MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: c1017de3-8db2-47ff-6abb-08dba7274cb6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjhERZyGiI3be1hxI3PcI5R4MjMKYo5NUI0gWtc17ophmTaHGSPPt+ceyCFC5/E5elEGU82l9t56ebmN1Vny8EDnmVO457A432gJtDPQwCMWoGFJw+srh4ZnuxZS63EqY2NkxSdP54zhL97nfRcGctiBm3GH8aiUgSWIFtKwLSEP4fOYUptDOktdK8R2g747uWO4CeF8F4JcpE6qpITAR18UInfLviWBZvyXyufqLK5E8MxY5trgCPoBL+N5EGmmNqZc/vYbZFN/Js8aYt2Cn8rM7kiZoARc81K8+X+2/9p9shqAmQzKdV+CcuuCgMp8qiyivhwdx95Zuh/uFtYzIUM3DuG/4hwVdfl82XHN1T39gWv1t7QycnBnLINo46Ij92Zi2yC5jlPKZHkBpsqzHBg091CdwoNwqmPp/5d3uwHCeEqFNweDghMn0CddRDk32gyRw+rVTkroqMBwJPg6ViKZJL0KUk+6+uJJOAtET3s6pLnCmet9Xog/4Wv6BI/utOx+sUF55gP5SMjQA3lFyxv235Cxf4z3jF7OkXv8z6woXELzdY9vI35nsUDfjtzl
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pHt16tENcsXRcBf2GN5A5WS3awqdpBnHPLRlqHTKHSX/EEJsjG74um2WRKfP?=
 =?us-ascii?Q?0uW+23hO+MwjMpgENhb2dzei6VIdsxWh3VDU2rvhzDG4JnmnPz9SHHVx3T9r?=
 =?us-ascii?Q?xEYBbe6ku67HYdC0j8jAiQHiNcK6UdawCCdOlHmHaBBjYFB/i0gOLfgVrydS?=
 =?us-ascii?Q?cZe66mvZPqDoGGpVg2E7DgSZyGuqLeAc9RmLXuRtKpNW4Rhlr0eJqi3CPt2K?=
 =?us-ascii?Q?IULm8bKjMDtWQSnrDbnollMyuDWaCf+hj1MsW1H5eEjzYODorzFtd/h0i6+S?=
 =?us-ascii?Q?8FEOyD9YqAIy/prQiy+/t8TD2baXv0R/rMR8KsnDjp8Ghi/VJ+hDa2DeHKQd?=
 =?us-ascii?Q?L3Zo9Tk3fqctXdyOiQgHWuoJqCSQVlv6ZLkBtPyGXUpUPI+/pv2uMBM7fxTA?=
 =?us-ascii?Q?u3FgnwsVDBPKsWUCNQXrqO93dNBQgNoaXoWBCOXd9FvTm1Mdb+su+3FpmizH?=
 =?us-ascii?Q?b57XRNMWx5Dmf/iPHKPbRAKFAnKMyQIDRaGH9AZ4UDSQ+TQ8wVwApUXfqPQS?=
 =?us-ascii?Q?3JtT/f04Z9LW+i4vMyJAQioYs183oFS6b3QOabo+dYfYVt+jUO448mGVAbQx?=
 =?us-ascii?Q?5zkQPISidt/7Zkd6SvmJfADESPXZxFvqzMD6l4cMa+GgWllRNQawLroc60/C?=
 =?us-ascii?Q?VIjT2599qijUz5bVdTzAgNZ0acsJn55ASe/28VdKsehxtwBQrreFXtCKrMV3?=
 =?us-ascii?Q?HDZsN8aCVGoOQ3Qnmc9IkOtTGu4EYWz7ubej/kLy9yi0mCh3fhfYLbRzqCGe?=
 =?us-ascii?Q?lWLZxJbfKQAKOihMj82L7unl19tyeJvVu0sNsCcXMIt2LSZ117UYwvyrpvBG?=
 =?us-ascii?Q?2Czn23KzeRghahoMviSrJUhTvXw5uv53UpyshECz4EXwa+IsJEe9QzqrjBpp?=
 =?us-ascii?Q?v7k5hd474KjqwBXJDx/Tc8n8rf8zJ/pMHcYcyJqfJOiUzY995N7i92eCmLpD?=
 =?us-ascii?Q?CdCMTkTtyY361NRvh0M85Qz+L8aR1eHzp2b+55wS19j/leZU2Qx7zLDqUY2J?=
 =?us-ascii?Q?bF3tr+s+8wyEyX4eL9WcKsA6M8SavyMWC4Xymz28NDWDOnZIMtOxIvCVFSYS?=
 =?us-ascii?Q?UBfAcen+OOY/G/YFoUdzQ1hHU6bm/bEdGeco8AqYTWghZSB9sgOpyts86f5D?=
 =?us-ascii?Q?V9cmAjXy4Yduwji2bUTqoUY0my/aPLjLMSCs07T7deKCenJx2oaTMqTK3dlz?=
 =?us-ascii?Q?Ot042Fyuh4ca5ug5VdLFHaCNA9RT8VG3JVzQ6G1OvZobnPYqYdqqbAyjQor0?=
 =?us-ascii?Q?U0naO7Ewl+kfySSRsAZjD5XBjThArKt8WcAervidCA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c1017de3-8db2-47ff-6abb-08dba7274cb6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 17:59:03.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8746
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 06:33:07PM +0200, Greg KH wrote:
> On Sun, Aug 27, 2023 at 09:02:07AM -0400, Oliver Crumrine wrote:
> > Make the octeon ethernet driver better adhere to the kernel
> > coding standard
> > 
> > Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
> > ---
> >  drivers/staging/octeon/ethernet.c     |  6 +--
> >  drivers/staging/octeon/octeon-stubs.h | 53 ++++++++++++++-------------
> >  2 files changed, 30 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
> > index 9eee28f2940c..8e1f4b987a25 100644
> > --- a/drivers/staging/octeon/ethernet.c
> > +++ b/drivers/staging/octeon/ethernet.c
> > @@ -201,8 +201,8 @@ EXPORT_SYMBOL(cvm_oct_free_work);
> >   */
> >  static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
> >  {
> > -	cvmx_pip_port_status_t rx_status;
> > -	cvmx_pko_port_status_t tx_status;
> > +	struct cvmx_pip_port_status rx_status;
> > +	struct cvmx_pko_port_status tx_status;
> >  	struct octeon_ethernet *priv = netdev_priv(dev);
> >  
> >  	if (priv->port < CVMX_PIP_NUM_INPUT_PORTS) {
> > @@ -798,7 +798,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
> >  
> >  	num_interfaces = cvmx_helper_get_number_of_interfaces();
> >  	for (interface = 0; interface < num_interfaces; interface++) {
> > -		cvmx_helper_interface_mode_t imode =
> > +		enum cvmx_helper_interface_mode imode =
> >  		    cvmx_helper_interface_get_mode(interface);
> >  		int num_ports = cvmx_helper_ports_on_interface(interface);
> >  		int port;
> > diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> > index 3e7b92cd2e35..1e3b32b304dc 100644
> > --- a/drivers/staging/octeon/octeon-stubs.h
> > +++ b/drivers/staging/octeon/octeon-stubs.h
> > @@ -213,14 +213,14 @@ enum cvmx_fau_op_size {
> >  	CVMX_FAU_OP_SIZE_64 = 3
> >  };
> >  
> > -typedef enum {
> > +enum cvmx_spi_mode {
> >  	CVMX_SPI_MODE_UNKNOWN = 0,
> >  	CVMX_SPI_MODE_TX_HALFPLEX = 1,
> >  	CVMX_SPI_MODE_RX_HALFPLEX = 2,
> >  	CVMX_SPI_MODE_DUPLEX = 3
> > -} cvmx_spi_mode_t;
> > +};
> >  
> > -typedef enum {
> > +enum cvmx_helper_interface_mode {
> >  	CVMX_HELPER_INTERFACE_MODE_DISABLED,
> >  	CVMX_HELPER_INTERFACE_MODE_RGMII,
> >  	CVMX_HELPER_INTERFACE_MODE_GMII,
> > @@ -231,20 +231,20 @@ typedef enum {
> >  	CVMX_HELPER_INTERFACE_MODE_PICMG,
> >  	CVMX_HELPER_INTERFACE_MODE_NPI,
> >  	CVMX_HELPER_INTERFACE_MODE_LOOP,
> > -} cvmx_helper_interface_mode_t;
> > +};
> >  
> > -typedef enum {
> > +enum cvmx_pow_wait {
> >  	CVMX_POW_WAIT = 1,
> >  	CVMX_POW_NO_WAIT = 0,
> > -} cvmx_pow_wait_t;
> > +};
> >  
> > -typedef enum {
> > +enum cvmx_pko_lock {
> >  	CVMX_PKO_LOCK_NONE = 0,
> >  	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
> >  	CVMX_PKO_LOCK_CMD_QUEUE = 2,
> > -} cvmx_pko_lock_t;
> > +};
> >  
> > -typedef enum {
> > +enum cvmx_pko_status {
> >  	CVMX_PKO_SUCCESS,
> >  	CVMX_PKO_INVALID_PORT,
> >  	CVMX_PKO_INVALID_QUEUE,
> > @@ -252,7 +252,7 @@ typedef enum {
> >  	CVMX_PKO_NO_MEMORY,
> >  	CVMX_PKO_PORT_ALREADY_SETUP,
> >  	CVMX_PKO_CMD_QUEUE_INIT_ERROR
> > -} cvmx_pko_status_t;
> > +};
> >  
> >  enum cvmx_pow_tag_type {
> >  	CVMX_POW_TAG_TYPE_ORDERED   = 0L,
> > @@ -384,7 +384,7 @@ union cvmx_ipd_sub_port_qos_cnt {
> >  	} s;
> >  };
> >  
> > -typedef struct {
> > +struct cvmx_pip_port_status {
> >  	uint32_t dropped_octets;
> >  	uint32_t dropped_packets;
> >  	uint32_t pci_raw_packets;
> > @@ -407,13 +407,13 @@ typedef struct {
> >  	uint32_t inb_packets;
> >  	uint64_t inb_octets;
> >  	uint16_t inb_errors;
> > -} cvmx_pip_port_status_t;
> > +};
> >  
> > -typedef struct {
> > +struct cvmx_pko_port_status {
> >  	uint32_t packets;
> >  	uint64_t octets;
> >  	uint64_t doorbell;
> > -} cvmx_pko_port_status_t;
> > +};
> >  
> >  union cvmx_pip_frm_len_chkx {
> >  	uint64_t u64;
> > @@ -1258,15 +1258,15 @@ static inline int octeon_is_simulation(void)
> >  }
> >  
> >  static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
> > -					    cvmx_pip_port_status_t *status)
> > +					    struct cvmx_pip_port_status *status)
> >  { }
> >  
> >  static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
> > -					    cvmx_pko_port_status_t *status)
> > +					    struct cvmx_pko_port_status *status)
> >  { }
> >  
> > -static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
> > -								   interface)
> > +static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
> > +									     interface)
> >  {
> >  	return 0;
> >  }
> > @@ -1342,11 +1342,11 @@ static inline unsigned int cvmx_get_core_num(void)
> >  }
> >  
> >  static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
> > -						       cvmx_pow_wait_t wait)
> > +						       enum cvmx_pow_wait wait)
> >  { }
> >  
> >  static inline void cvmx_pow_work_request_async(int scr_addr,
> > -					       cvmx_pow_wait_t wait)
> > +					       enum cvmx_pow_wait wait)
> >  { }
> >  
> >  static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
> > @@ -1356,13 +1356,13 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
> >  	return wqe;
> >  }
> >  
> > -static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
> > +static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait wait)
> >  {
> >  	return (void *)(unsigned long)wait;
> >  }
> >  
> >  static inline int cvmx_spi_restart_interface(int interface,
> > -					cvmx_spi_mode_t mode, int timeout)
> > +					     enum cvmx_spi_mode mode, int timeout)
> >  {
> >  	return 0;
> >  }
> > @@ -1381,12 +1381,13 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
> >  }
> >  
> >  static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
> > -						cvmx_pko_lock_t use_locking)
> > +						enum cvmx_pko_lock use_locking)
> >  { }
> >  
> > -static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
> > -		uint64_t queue, union cvmx_pko_command_word0 pko_command,
> > -		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
> > +static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port, uint64_t queue,
> > +							       union cvmx_pko_command_word0 pko_command,
> > +							       union cvmx_buf_ptr packet,
> > +							       enum cvmx_pko_lock use_locking)
> >  {
> >  	return 0;
> >  }
> > -- 
> > 2.39.3
> > 
> > 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - Your patch did many different things all at once, making it difficult
>   to review.  All Linux kernel patches need to only do one thing at a
>   time.  If you need to do multiple things (such as clean up all coding
>   style issues in a file/driver), do it in a sequence of patches, each
>   one doing only one thing.  This will make it easier to review the
>   patches to ensure that they are correct, and to help alleviate any
>   merge issues that larger patches can cause.
> 
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.
> 
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot

Hi, 

I was wondering what your patch bot meant about #1. How would I go about
splitting this patch up to make it more readable? It seemed to me as if
it should all be one patch, as it fixes multiple of the same kind of
issue (using typedefs) that scrips/checkpatch.pl pointed out. Should I
have split it up into multiple patches for each file? Looking at the
linux-kernel mailing list, I saw other kernel developers putting diffs
for multiple files into one patch, so I though it would be okay, but if
isn't good practice, please let me know.

I agree with #2, and I will make sure to read the documentation on how
to submit new versions of a patch before I submit v3.

Thank you for your time,
Oliver
