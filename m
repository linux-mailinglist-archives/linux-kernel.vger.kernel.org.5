Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211D67DC905
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbjJaJH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbjJaJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:07:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F41A2;
        Tue, 31 Oct 2023 02:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698743240; x=1730279240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eqHmgi7daxr3/IGkgnLFwT7/+fsO4uBKjo5lF73zSUA=;
  b=La6GSWmNOC8E15bTjTvzy37BBjgwE1I2CeScM3GQAG9OjF/MjkV5WGZ2
   U2mm8mOxy42vlUQ0He9viWN94l/gjOCLJ3P0dKQY8ZLFBQ41uXYLlll/g
   k2dNiekZ83svV+M3wiLYzWspfvogf1dQFkQxPsVtVKzJjZ6oUngkYo0VS
   BKSf/6WigHsgJHJPYcxgEqTZsv58Fagc0EmR5dgyT1y7UVMNH7n2UlN9/
   eUPidgiGyhioZx+UcRZpjz9x90yKuGxQeRLUTrhXZSb/CXWh0cMG7VVO/
   2GTGfF+V3jXGw56ESjvU9weMl3ahQ2vv+ROnUqonAPIYAu+wuD071CBLU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="378629337"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="378629337"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 02:07:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="884140841"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="884140841"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 02:07:18 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 4570311F894;
        Tue, 31 Oct 2023 10:58:04 +0200 (EET)
Date:   Tue, 31 Oct 2023 08:58:04 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] ACPI: scan: Extract MIPI DiSco for Imaging data
 into swnodes
Message-ID: <ZUDBnEJ41tc7nnka@kekkonen.localdomain>
References: <2187487.irdbgypaU6@kreacher>
 <7609686.EvYhyI6sBW@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7609686.EvYhyI6sBW@kreacher>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On subject:

s/DiSco/DisCo/

On Fri, Oct 20, 2023 at 04:39:27PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add information extracted from the MIPI DiSco for Imaging device

Ditto.

> properties to software nodes created during the CSI-2 connection graph
> discovery.
> 
> Link: https://www.mipi.org/specifications/mipi-di

This URL is broken. The correct URL is:

	https://www.mipi.org/specifications/mipi-disco-imaging

> Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/internal.h |    1 
>  drivers/acpi/mipi-di.c  |  240 +++++++++++++++++++++++++++++++++++++++++++++++-

How about mipi-disco.c? I wouldn't mind having mipi-disco-imaging.c either.

>  drivers/acpi/scan.c     |   12 ++
>  include/acpi/acpi_bus.h |   10 ++
>  4 files changed, 259 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/acpi/mipi-di.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/mipi-di.c
> +++ linux-pm/drivers/acpi/mipi-di.c
> @@ -6,12 +6,16 @@
>   *
>   * Support MIPI DisCo for Imaging by parsing ACPI _CRS CSI-2 records defined in
>   * Section 6.4.3.8.2.4 "Camera Serial Interface (CSI-2) Connection Resource
> - * Descriptor" of ACPI 6.5.
> + * Descriptor" of ACPI 6.5 and using device properties defined by the MIPI DisCo
> + * for Imaging specification.
>   *
>   * The implementation looks for the information in the ACPI namespace (CSI-2
>   * resource descriptors in _CRS) and constructs software nodes compatible with
>   * Documentation/firmware-guide/acpi/dsd/graph.rst to represent the CSI-2
> - * connection graph.
> + * connection graph.  The software nodes are then populated with the data
> + * extracted from the _CRS CSI-2 resource descriptors and the MIPI DisCo
> + * for Imaging device properties present in _DSD for the ACPI device objects
> + * with CSI-2 connections.
>   */
>  
>  #include <linux/acpi.h>
> @@ -434,6 +438,238 @@ void acpi_mipi_scan_crs_csi2(void)
>  		prepare_crs_csi2_swnodes(csi2);
>  }
>  
> +/*
> + * Get the index of the next property in the property array, with a given
> + * maximum value.
> + */
> +#define NEXT_PROPERTY(index, max)			\
> +	(WARN_ON((index) > ACPI_DEVICE_SWNODE_##max) ?	\
> +	 ACPI_DEVICE_SWNODE_##max : (index)++)
> +
> +static void init_csi2_port_local(struct acpi_device *adev,
> +				 struct acpi_device_software_node_port *port,
> +				 struct fwnode_handle *port_fwnode,
> +				 unsigned int index)
> +{
> +	acpi_handle handle = acpi_device_handle(adev);
> +	unsigned int num_link_freqs;
> +	int ret;
> +
> +	ret = fwnode_property_count_u64(port_fwnode, "mipi-img-link-frequencies");
> +	if (ret <= 0)
> +		return;
> +
> +	num_link_freqs = ret;
> +	if (num_link_freqs > ARRAY_SIZE(port->link_frequencies)) {
> +		acpi_handle_info(handle, "Too many link frequencies: %u\n",
> +				 num_link_freqs);
> +		num_link_freqs = ARRAY_SIZE(port->link_frequencies);
> +	}
> +
> +	ret = fwnode_property_read_u64_array(port_fwnode,
> +					     "mipi-img-link-frequencies",
> +					     port->link_frequencies,
> +					     num_link_freqs);
> +	if (ret) {
> +		acpi_handle_info(handle, "Unable to get link frequencies (%d)\n",
> +				 ret);
> +		return;
> +	}
> +
> +	port->ep_props[NEXT_PROPERTY(index, EP_LINK_FREQUENCIES)] =
> +				PROPERTY_ENTRY_U64_ARRAY_LEN("link-frequencies",
> +							     port->link_frequencies,
> +							     num_link_freqs);
> +}
> +
> +static void init_csi2_port(struct acpi_device *adev,
> +			   struct acpi_device_software_nodes *swnodes,
> +			   struct acpi_device_software_node_port *port,
> +			   struct fwnode_handle *port_fwnode,
> +			   unsigned int port_index)
> +{
> +	unsigned int ep_prop_index = ACPI_DEVICE_SWNODE_EP_CLOCK_LANES;
> +	acpi_handle handle = acpi_device_handle(adev);
> +	u8 val[ARRAY_SIZE(port->data_lanes)];
> +	unsigned int num_lanes = 0;
> +	int ret;
> +
> +	if (GRAPH_PORT_NAME(port->port_name, port->port_nr))
> +		return;
> +
> +	swnodes->nodes[ACPI_DEVICE_SWNODE_PORT(port_index)] =
> +			SOFTWARE_NODE(port->port_name, port->port_props,
> +				      &swnodes->nodes[ACPI_DEVICE_SWNODE_ROOT]);
> +
> +	ret = fwnode_property_read_u8(port_fwnode, "mipi-img-clock-lane", val);
> +	if (!ret)
> +		port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_CLOCK_LANES)] =
> +			PROPERTY_ENTRY_U32("clock-lanes", val[0]);
> +
> +	ret = fwnode_property_count_u8(port_fwnode, "mipi-img-data-lanes");
> +	if (ret > 0) {
> +		num_lanes = ret;
> +
> +		if (num_lanes > ARRAY_SIZE(port->data_lanes)) {
> +			acpi_handle_info(handle, "Too many data lanes: %u\n",
> +					 num_lanes);
> +			num_lanes = ARRAY_SIZE(port->data_lanes);
> +		}
> +
> +		ret = fwnode_property_read_u8_array(port_fwnode,
> +						    "mipi-img-data-lanes",
> +						    val, num_lanes);
> +		if (!ret) {
> +			unsigned int i;
> +
> +			for (i = 0; i < num_lanes; i++)
> +				port->data_lanes[i] = val[i];
> +
> +			port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_DATA_LANES)] =
> +				PROPERTY_ENTRY_U32_ARRAY_LEN("data-lanes",
> +							     port->data_lanes,
> +							     num_lanes);
> +		}
> +	}
> +
> +	ret = fwnode_property_count_u8(port_fwnode, "mipi-img-lane-polarities");
> +	if (ret > 0) {
> +		unsigned long mask;
> +		unsigned int i;
> +
> +		/*
> +		 * Total number of lanes here is clock lane + data lanes.
> +		 * Require that number to be low enough so they all can be
> +		 * covered by the bits in one byte.
> +		 */
> +		BUILD_BUG_ON(BITS_PER_TYPE(u8) <= ARRAY_SIZE(port->data_lanes));
> +
> +		fwnode_property_read_u8_array(port_fwnode,
> +					      "mipi-img-lane-polarities",
> +					      val, 1);
> +
> +		for (mask = val[0], i = 0; i < num_lanes + 1; i++)
> +			port->lane_polarities[i] = test_bit(i, &mask);

This works only up to seven lanes. I guess this can be addressed later in
case we get devices with 8 lanes. But adding a comment here (or where the
maximum number of lanes is defined) that this needs to be fixed would be
prudent to avoid introducing a bug later on.

> +
> +		port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_LANE_POLARITIES)] =
> +				PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polarities",
> +							     port->lane_polarities,
> +							     1 + num_lanes);
> +	} else {
> +		acpi_handle_info(handle, "No lane polarity bytes\n");
> +	}
> +
> +	swnodes->nodes[ACPI_DEVICE_SWNODE_EP(port_index)] =
> +		SOFTWARE_NODE("endpoint@0", swnodes->ports[port_index].ep_props,
> +			      &swnodes->nodes[ACPI_DEVICE_SWNODE_PORT(port_index)]);
> +
> +	if (port->crs_csi2_local)
> +		init_csi2_port_local(adev, port, port_fwnode, ep_prop_index);
> +}
> +
> +#define MIPI_IMG_PORT_PREFIX "mipi-img-port-"
> +
> +static struct fwnode_handle *get_mipi_port_handle(struct fwnode_handle *adev_fwnode,
> +						  unsigned int port_nr)
> +{
> +	char port_name[sizeof(MIPI_IMG_PORT_PREFIX) + 2];
> +
> +	if (snprintf(port_name, sizeof(port_name), "%s%u",
> +		     MIPI_IMG_PORT_PREFIX, port_nr) >= sizeof(port_name))
> +		return NULL;
> +
> +	return fwnode_get_named_child_node(adev_fwnode, port_name);
> +}
> +
> +static void init_crs_csi2_swnodes(struct crs_csi2 *csi2)
> +{
> +	struct acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER };
> +	struct acpi_device_software_nodes *swnodes = csi2->swnodes;
> +	acpi_handle handle = csi2->handle;
> +	struct fwnode_handle *adev_fwnode;
> +	struct acpi_device *adev;
> +	acpi_status status;
> +	unsigned int i;
> +	int ret;
> +
> +	/*
> +	 * Bail out if the swnodes are not available (either they have not been
> +	 * allocated or they have been assigned to the device already).
> +	 */
> +	if (!swnodes)
> +		return;
> +
> +	adev = acpi_fetch_acpi_dev(handle);
> +	if (!adev)
> +		return;
> +
> +	adev_fwnode = acpi_fwnode_handle(adev);
> +
> +	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		acpi_handle_info(handle, "Unable to get the path name\n");
> +		return;
> +	}
> +
> +	swnodes->nodes[ACPI_DEVICE_SWNODE_ROOT] =
> +			SOFTWARE_NODE(buffer.pointer, swnodes->dev_props, NULL);
> +
> +	for (i = 0; i < swnodes->num_ports; i++) {
> +		struct acpi_device_software_node_port *port = &swnodes->ports[i];
> +		struct fwnode_handle *port_fwnode;
> +
> +		/*
> +		 * The MIPI DisCo for Imaging specification defines _DSD device
> +		 * properties for providing CSI-2 port parameters that can be
> +		 * accessed through the generic device properties framework.  To
> +		 * access them, it is first necessary to find the data node
> +		 * representing the port under the given ACPI device object.
> +		 */
> +		port_fwnode = get_mipi_port_handle(adev_fwnode, port->port_nr);
> +		if (!port_fwnode) {
> +			acpi_handle_info(handle,
> +					 "MIPI port name too long for port %u\n",
> +					 port->port_nr);
> +			continue;
> +		}
> +
> +		init_csi2_port(adev, swnodes, port, port_fwnode, i);
> +
> +		fwnode_handle_put(port_fwnode);
> +	}
> +
> +	ret = software_node_register_node_group(swnodes->nodeptrs);
> +	if (ret < 0) {
> +		acpi_handle_info(handle,
> +				 "Unable to register software nodes (%d)\n", ret);
> +		return;
> +	}
> +
> +	adev->swnodes = swnodes;
> +	adev_fwnode->secondary = software_node_fwnode(swnodes->nodes);
> +
> +	/*
> +	 * Prevents the swnodes from this csi2 entry from being assigned again
> +	 * or freed prematurely.
> +	 */
> +	csi2->swnodes = NULL;
> +}
> +
> +/**
> + * acpi_mipi_init_crs_csi2_swnodes - Initialize _CRS CSI-2 software nodes
> + *
> + * Use MIPI DiSco for Imaging device properties to finalize the initialization
> + * of CSI-2 software nodes for all ACPI device objects that have been already
> + * enumerated.
> + */
> +void acpi_mipi_init_crs_csi2_swnodes(void)
> +{
> +	struct crs_csi2 *csi2, *csi2_tmp;
> +
> +	list_for_each_entry_safe(csi2, csi2_tmp, &acpi_mipi_crs_csi2_list, entry)
> +		init_crs_csi2_swnodes(csi2);
> +}
> +
>  /**
>   * acpi_mipi_crs_csi2_cleanup - Free _CRS CSI-2 temporary data
>   */
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -287,6 +287,7 @@ static inline void acpi_init_lpit(void)
>  
>  void acpi_mipi_check_crs_csi2(acpi_handle handle);
>  void acpi_mipi_scan_crs_csi2(void);
> +void acpi_mipi_init_crs_csi2_swnodes(void);
>  void acpi_mipi_crs_csi2_cleanup(void);
>  
>  #endif /* _ACPI_INTERNAL_H_ */
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2447,6 +2447,13 @@ static void acpi_scan_postponed_branch(a
>  
>  	acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
>  			    acpi_bus_check_add_2, NULL, NULL, (void **)&adev);
> +
> +	/*
> +	 * Populate the ACPI _CRS CSI-2 software nodes for the ACPI devices that
> +	 * have been added above.
> +	 */
> +	acpi_mipi_init_crs_csi2_swnodes();
> +
>  	acpi_bus_attach(adev, NULL);
>  }
>  
> @@ -2516,11 +2523,12 @@ int acpi_bus_scan(acpi_handle handle)
>  		return -ENODEV;
>  
>  	/*
> -	 * Allocate ACPI _CRS CSI-2 software nodes using information extracted
> +	 * Set up ACPI _CRS CSI-2 software nodes using information extracted
>  	 * from the _CRS CSI-2 resource descriptors during the ACPI namespace
> -	 * walk above.
> +	 * walk above and MIPI DiSco for Imaging device properties.
>  	 */
>  	acpi_mipi_scan_crs_csi2();
> +	acpi_mipi_init_crs_csi2_swnodes();
>  
>  	acpi_bus_attach(device, (void *)true);
>  
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -366,10 +366,17 @@ struct acpi_device_data {
>  
>  struct acpi_gpio_mapping;
>  
> +#define ACPI_DEVICE_SWNODE_ROOT			0
> +
>  #define ACPI_DEVICE_CSI2_DATA_LANES		4
>  
>  #define ACPI_DEVICE_SWNODE_PORT_NAME_LENGTH	8
>  
> +enum acpi_device_swnode_dev_props {
> +	ACPI_DEVICE_SWNODE_DEV_NUM_OF,
> +	ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES
> +};
> +
>  enum acpi_device_swnode_port_props {
>  	ACPI_DEVICE_SWNODE_PORT_REG,
>  	ACPI_DEVICE_SWNODE_PORT_NUM_OF,
> @@ -425,12 +432,14 @@ struct acpi_device_software_node_port {
>  
>  /**
>   * struct acpi_device_software_nodes - Software nodes for an ACPI device
> + * @dev_props: Device properties.
>   * @nodes: Software nodes for root as well as ports and endpoints.
>   * @nodeprts: Array of software node pointers, for (un)registering them.
>   * @ports: Information related to each port and endpoint within a port.
>   * @num_ports: The number of ports.
>   */
>  struct acpi_device_software_nodes {
> +	struct property_entry dev_props[ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES];
>  	struct software_node *nodes;
>  	const struct software_node **nodeptrs;
>  	struct acpi_device_software_node_port *ports;
> @@ -455,6 +464,7 @@ struct acpi_device {
>  	struct acpi_device_data data;
>  	struct acpi_scan_handler *handler;
>  	struct acpi_hotplug_context *hp;
> +	struct acpi_device_software_nodes *swnodes;
>  	const struct acpi_gpio_mapping *driver_gpios;
>  	void *driver_data;
>  	struct device dev;
> 
> 
> 

-- 
Regards,

Sakari Ailus
